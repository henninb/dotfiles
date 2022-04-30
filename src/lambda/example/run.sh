#!/bin/sh

zip function.zip index.js

aws lambda list-functions
aws lambda create-function --function-name myFunction --zip-file fileb://function.zip --handler index.handler --runtime nodejs12.x --role arn:aws:iam::832304081285:role/service-role
# aws lambda create-function --function-name mytestFunction --role rn:aws:iam::1234:role --handler mytestFunction.lambda_handler -runtime nodejs12.x fileb://function.zip

# arn:aws:iam::832304081285:role/service-role/helloFunction-role-62rqy1hf

exit 0
