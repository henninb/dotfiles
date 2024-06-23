#!/bin/sh

# Define variables
ROLE_NAME="edge-lambda-role"
# POLICY_NAME="LambdaEdgePolicy"
POLICY_NAME="AWSLambdaEdgeExecutionRole"
POLICY_FILE="lambda-edge-policy.json"
FUNCTION_NAME="my-edge-function2"

# keep for troubleshooting
#aws iam list-roles --query 'Roles[*].RoleName' --output text | tr '\t' '\n'
#aws iam list-policies --query 'Policies[*].PolicyName' --output text | tr '\t' '\n'

# Create the policy document
cat <<EOT > $POLICY_FILE
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "*"
        }
    ]
}
EOT

aws iam create-role --role-name edge-lambda-role --assume-role-policy-document file://edge-lambda-role.json
ROLE_ARN=$(aws iam get-role --role-name $ROLE_NAME --query 'Role.Arn' --output text)
echo $ROLE_ARN

rm basic-auth.zip
zip basic-auth.zip index.js index.mjs

aws lambda create-function --function-name $FUNCTION_NAME \
--runtime nodejs20.x \
--role "$ROLE_ARN" \
--handler index.handler \
--zip-file fileb://basic-auth.zip \
--region us-east-1


FUNCTION_ARN=$(aws lambda get-function --function-name $FUNCTION_NAME --query 'Configuration.FunctionArn' --output text)
echo function_ARN
echo $FUNCTION_ARN

# Create the policy
aws iam create-policy --policy-name $POLICY_NAME --policy-document file://$POLICY_FILE --query 'Policy.Arn' --output text

POLICY_ARN=$(aws iam list-policies --query "Policies[?PolicyName=='$POLICY_NAME'].Arn" --output text)

# Attach the policy to the role
echo aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN

aws lambda publish-version --function-name $FUNCTION_NAME

exit 0
