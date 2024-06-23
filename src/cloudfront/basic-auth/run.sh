#!/bin/sh

BUCKET_NAME=bhenning-static2-bucket
ROLE_NAME="edge-lambda1-role"
FUNCTION_NAME="basic-auth4-function"
REGION=us-east-1
CALL_REFERENCE=basic-auth-$(date +%s)

cat <<  EOF > "$HOME/tmp/edge-lambda-role.json"
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com",
        "Service": "edgelambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

# Check if the bucket exists
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "Bucket exists. Deleting contents and bucket..."
  aws s3 rm s3://${BUCKET_NAME} --recursive
  aws s3api delete-bucket --bucket $BUCKET_NAME
else
  echo "Bucket does not exist. Skipping delete."
fi

echo aws s3api create-bucket --bucket ${BUCKET_NAME} --region us-east-1
aws s3api create-bucket --bucket ${BUCKET_NAME} --region us-east-1

# not sure if I need this
# echo aws iam put-user-policy --user-name z037640henninb --policy-name S3BucketPolicy --policy-document file://$HOME/tmp/iam-s3-policy.json
# aws iam put-user-policy --user-name z037640henninb --policy-name S3BucketPolicy --policy-document file://$HOME/tmp/iam-s3-policy.json

echo aws s3 website s3://${BUCKET_NAME}/ --index-document index.html
aws s3 website s3://${BUCKET_NAME}/ --index-document index.html


echo aws s3 sync ./public s3://${BUCKET_NAME}/ --delete
aws s3 sync ./public s3://${BUCKET_NAME}/ --delete

aws s3 ls
aws s3 ls s3://$BUCKET_NAME --recursive --human-readable --summarize

# aws iam list-user-policies --user-name z037640henninb

rm -f basic-auth.zip
zip basic-auth.zip index.js

aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://$HOME/tmp/edge-lambda-role.json
# aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaEdgeExecutionRole
# aws iam list-roles | jq '.Roles[].RoleName'

# aws lambda delete-function --function-name $FUNCTION_NAME

ROLE_ARN=$(aws iam get-role --role-name $ROLE_NAME --query 'Role.Arn' --output text)
echo $ROLE_ARN

if aws lambda get-function --function-name $FUNCTION_NAME 2>/dev/null; then
  echo "Lambda function exists. Proceeding to update code..."
  aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://basic-auth.zip
else
  echo "Lambda function does not exist so create one."
  aws lambda create-function --function-name $FUNCTION_NAME \
  --runtime nodejs20.x \
  --role "$ROLE_ARN" \
  --handler index.handler \
  --zip-file fileb://basic-auth.zip \
  --region us-east-1
   STATUS="Pending"
  while [ "$STATUS" != "Active" ]; do
    sleep 5
    STATUS=$(aws lambda get-function --function-name $FUNCTION_NAME | jq -r '.Configuration.State')
    echo "Creation status: $STATUS"

    if [ "$STATUS" = "Failed" ]; then
      echo "Lambda function creation failed."
      exit 1
    fi
  done
fi

# aws iam put-role-policy --role-name $ROLE_NAME --policy-name LambdaEdgePolicy --policy-document file://$HOME/tmp/lambda-policy.json

#echo "Publishing the Lambda function '$FUNCTION_NAME'..."
#PUBLISH_OUTPUT=$(aws lambda publish-version --function-name $FUNCTION_NAME)
echo "Publishing the Lambda function '$FUNCTION_NAME'..."
while true; do
  PUBLISH_OUTPUT=$(aws lambda publish-version --function-name $FUNCTION_NAME 2>&1)
  if echo "$PUBLISH_OUTPUT" | grep -q "ResourceConflictException"; then
    echo "Resource conflict detected. Retrying..."
    sleep 5
  else
    break
  fi
done

VERSION=$(echo $PUBLISH_OUTPUT | jq -r '.Version')

if [ -z "$PUBLISH_OUTPUT" ]; then
  echo "Failed to publish the Lambda function '$FUNCTION_NAME'."
  exit 1
fi

# FUNCTION_ARN=$(aws lambda get-function --function-name $FUNCTION_NAME --query 'Configuration.FunctionArn' --output text)
# echo $FUNCTION_ARN

echo "The Lambda function '$FUNCTION_NAME' has been successfully published."

# aws lambda add-permission --function-name $FUNCTION_NAME --statement-id AllowCloudFrontService --action lambda:GetFunction --principal edgelambda.amazonaws.com --source-arn arn:aws:lambda:us-east-1:423310193800:function:$FUNCTION_NAME:9

PUBLISHED_FUNCTION_ARN=$(aws lambda publish-version --function-name $FUNCTION_NAME --query 'FunctionArn' --output text)
echo $PUBLISHED_FUNCTION_ARN

# jq --arg new_arn "$PUBLISHED_FUNCTION_ARN" '.DefaultCacheBehavior.LambdaFunctionAssociations.Items[0].LambdaFunctionARN = $new_arn' bhenning-cloudfront-distribution.json > tmp.json && mv tmp.json bhenning-cloudfront-distribution.json

# do I need this?
# aws lambda add-permission --function-name $FUNCTION_NAME --statement-id AllowCloudFrontService --action lambda:GetFunction --principal edgelambda.amazonaws.com --source-arn "$PUBLISHED_FUNCTION_ARN"

# aws cloudfront create-distribution --distribution-config file://$HOME/tmp/bhenning-cloudfront-distribution.json
# Create the CloudFront distribution
cat <<  EOF > "$HOME/tmp/bhenning-cloudfront-distribution.json"
{
  "CallerReference": "$CALL_REFERENCE",
  "Aliases": {
    "Quantity": 0
  },
  "DefaultRootObject": "index.html",
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "1",
        "DomainName": "$BUCKET_NAME.s3.us-east-1.amazonaws.com",
        "OriginPath": "",
        "CustomHeaders": {
          "Quantity": 0
        },
        "S3OriginConfig": {
          "OriginAccessIdentity": ""
        },
        "ConnectionAttempts": 3,
        "ConnectionTimeout": 10,
        "OriginShield": {
          "Enabled": false
        },
        "OriginAccessControlId": "E1BA20KXKSLPY3"
      }
    ]
  },
  "OriginGroups": {
    "Quantity": 0
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "1",
    "TrustedSigners": {
      "Enabled": false,
      "Quantity": 0
    },
    "TrustedKeyGroups": {
      "Enabled": false,
      "Quantity": 0
    },
    "ViewerProtocolPolicy": "https-only",
    "AllowedMethods": {
      "Quantity": 2,
      "Items": [
        "HEAD",
        "GET"
      ],
      "CachedMethods": {
        "Quantity": 2,
        "Items": [
          "HEAD",
          "GET"
        ]
      }
    },
    "SmoothStreaming": false,
    "Compress": false,
    "LambdaFunctionAssociations": {
      "Quantity": 1,
      "Items": [
        {
          "LambdaFunctionARN": "$PUBLISHED_FUNCTION_ARN",
          "EventType": "viewer-request"
        }
      ]
    },
    "FunctionAssociations": {
      "Quantity": 0
    },
    "FieldLevelEncryptionId": "",
    "CachePolicyId": "658327ea-f89d-4fab-a63d-7e88639e58f6"
  },
  "CacheBehaviors": {
    "Quantity": 0
  },
  "CustomErrorResponses": {
    "Quantity": 0
  },
  "Comment": "",
  "Logging": {
    "Enabled": false,
    "IncludeCookies": false,
    "Bucket": "",
    "Prefix": ""
  },
  "PriceClass": "PriceClass_All",
  "Enabled": true,
  "ViewerCertificate": {
    "CloudFrontDefaultCertificate": true,
    "SSLSupportMethod": "vip",
    "MinimumProtocolVersion": "TLSv1",
    "CertificateSource": "cloudfront"
  },
  "Restrictions": {
    "GeoRestriction": {
      "RestrictionType": "none",
      "Quantity": 0
    }
  },
  "WebACLId": "",
  "HttpVersion": "http2",
  "IsIPV6Enabled": false,
  "ContinuousDeploymentPolicyId": "",
  "Staging": false
}
EOF

CREATE_DISTRIBUTION_OUTPUT=$(aws cloudfront create-distribution --distribution-config file://$HOME/tmp/bhenning-cloudfront-distribution.json)
DISTRIBUTION_ARN=$(echo $CREATE_DISTRIBUTION_OUTPUT | jq -r '.Distribution.ARN')
echo $DISTRIBUTION_ARN

cat <<  EOF > "$HOME/tmp/bhenning-static-bucket-policy.json"
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipalReadOnly",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::$BUCKET_NAME/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": [
                        "$DISTRIBUTION_ARN"
                    ]
                }
            }
        }
    ]
}
EOF

echo aws s3api put-bucket-policy --bucket ${BUCKET_NAME} --policy file://$HOME/tmp/bhenning-static-bucket-policy.json
aws s3api put-bucket-policy --bucket ${BUCKET_NAME} --policy file://$HOME/tmp/bhenning-static-bucket-policy.json

# echo create oac
# aws cloudfront create-origin-access-control \
#     --origin-access-control-config CallerReference=$CALL_REFERENCE \
#     Name=MyOAC \
#     Description="OAC for $BUCKET_NAME" \
#     OriginAccessControlOriginType=s3 \
#     SigningBehavior=always \
#     SigningProtocol=sigv4

# Extract the distribution domain name from the output
DISTRIBUTION_DOMAIN_NAME=$(echo $CREATE_DISTRIBUTION_OUTPUT | jq -r '.Distribution.DomainName')
echo $DISTRIBUTION_DOMAIN_NAME

# aws cloudfront create-cloud-front-origin-access-identity --cloud-front-origin-access-identity-config CallerReference=unique-string,Comment="OAI for static site"

# aws lambda add-permission --function-name YOUR_LAMBDA_FUNCTION_NAME --statement-id AllowCloudFrontInvocation --principal edgelambda.amazonaws.com --action lambda:InvokeFunction --source-arn arn:aws:cloudfront::ACCOUNT_ID:distribution/YOUR_CLOUDFRONT_DISTRIBUTION_ID
# aws iam list-attached-role-policies --role-name $ROLE_NAME
# echo aws iam detach-role-policy --role-name $ROLE_NAME --policy-arn POLICY_ARN

# keep for troubleshooting
#aws iam list-roles --query 'Roles[*].RoleName' --output text | tr '\t' '\n'
#aws iam list-policies --query 'Policies[*].PolicyName' --output text | tr '\t' '\n'


exit 0
