## Create an s3 bucket 
aws s3 mb s3://replication-dgt-16072025 

aws s3 mb s3://replication-dgt-us-east-16072025 --region us-east-1

## Turn on s3 versioning
aws s3api put-bucket-versioning --bucket replication-dgt-16072025 --versioning-configuration Status=Enabled

aws s3api put-bucket-versioning --bucket replication-dgt-us-east-16072025 --versioning-configuration Status=Enabled

## Create Role and policy for s3 replication 
aws iam create-policy \
    --policy-name policy-replication-dgt \
    --policy-document file://policy.json


aws iam create-role \
    --role-name s3-replication-role \
    --assume-role-policy-document file://trust.json


aws iam attach-role-policy \
    --policy-arn arn:aws:iam::816069170623:policy/policy-replication-dgt \
    --role-name s3-replication-role

## Turn on Replication

aws s3api put-bucket-replication \
    --bucket replication-dgt-16072025  \
    --replication-configuration file://replication.json

## Create a file and upload to our bucket
echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://replication-dgt-16072025/hello.txt

## Check destination biucket to see if replication worked

aws s3 ls s3://replication-dgt-us-east-16072025

## CleanUP
aws s3 rm s3://replication-dgt-16072025/hello.txt
aws s3 rm s3://replication-dgt-us-east-16072025/hello.txt

aws s3 rb s3://replication-dgt-16072025 
aws s3 rb s3://replication-dgt-us-east-16072025 