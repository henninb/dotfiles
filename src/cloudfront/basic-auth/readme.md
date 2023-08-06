https://www.youtube.com/watch?v=gc3w_bMtcQE&t=419s


cloudfront

cloudfront distribution

domain: henninb-bucket.s3.amazonaws.com


use OAC (origin access control) , replacement for oai



{
    "Version": "2012-10-17",
    "Statement": {
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::henninb-bucket/*",
        "Condition": {
            "StringEquals": {
                "AWS:SourceArn": "arn:aws:cloudfront::423310193800:distribution/E3OLP8TWNJH0IS"
            }
        }
    }
}


{
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E1FSQL63PSSD8K"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::henninb-bucket/*"
        }
    ]
}

{
    "Version": "2012-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity YOUR_OAI_ID"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*"
        }
    ]
}


lambda publish new version


use lambda@edge

arn:aws:lambda:us-east-1:423310193800:function:lambda-basic-auth
arn:aws:lambda:us-east-1:423310193800:function:lambda-basic-auth:1

arn:aws:lambda:us-east-1:423310193800:function:lambda-basic-auth:2

arn:aws:lambda:us-east-1:423310193800:function:basic-auth:1


make sure the permission of the lambda has an IAM of Lambda@Edge

Publish the function
deploy a version of the function


Basic information
Function name
Enter a name that describes the purpose of your function.
test
Use only letters, numbers, hyphens, or underscores with no spaces.
RuntimeInfo
Choose the language to use to write your function. Note that the console code editor supports only Node.js, Python, and Ruby.

Node.js 14.x

ArchitectureInfo
Choose the instruction set architecture you want for your function code.
x86_64
arm64
PermissionsInfo
By default, Lambda will create an execution role with permissions to upload logs to Amazon CloudWatch Logs. You can customize this default role later when adding triggers.

Change default execution role
Execution role
Choose a role that defines the permissions of your function. To create a custom role, go to the IAM console .
Create a new role with basic Lambda permissions
Use an existing role
Create a new role from AWS policy templates
Role creation might take a few minutes. Please do not delete the role or edit the trust or permissions policies in this role.
Role name
Enter a name for your new role.
test
Use only letters, numbers, hyphens, or underscores with no spaces.
Policy templates - optionalInfo
Choose one or more policy templates.

Basic Lambda@Edge permissions (for CloudFront trigger)
CloudWatch Logs

