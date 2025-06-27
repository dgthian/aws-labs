## Create a new folder

```sh
aws s3 mb s3://object-lock-dgt-26062025
```
## Turn on S3 Versioning
aws s3api put-bucket-versioning --bucket object-lock-dgt-26062025 --versioning-configuration Status=Enabled

## Turn on Object Locking
aws s3api put-object-lock-configuration \
    --bucket object-lock-dgt-26062025 \
    --object-lock-configuration '{ "ObjectLockEnabled": "Enabled", "Rule": { "DefaultRetention": { "Mode": "GOVERNANCE", "Days": 1 }}}'


## Create new file and upoald into bucket

echo "This is the Gov file" > gov.txt

aws s3 cp gov.txt s3://object-lock-dgt-26062025

## delete the version file 
aws s3api delete-object --bucket object-lock-dgt-26062025 --key gov.txt --version-id is8AISW.6uS135YaAGjerib3Mmb.aoFi --bypass-governance-retention

## Use coompliance mode for s3 object 

aws s3api put-object --bucket object-lock-dgt-26062025 --key gov.txt --body compliance.txt --object-lock-mode COMPLIANCE --object-lock-retain-until-date "2025-06-28T00:00:00Z"

## Try and delete specific version
aws s3api delete-object --bucket object-lock-dgt-26062025 --key gov.txt --version-id nYncUF_T7jqYtoYPBEwUe4LRoQDzKpCG 

## New File
touch legal.txt
aws s3 cp legal.txt s3://object-lock-dgt-26062025/legal.txt

aws s3api put-object-legal-hold --bucket object-lock-dgt-26062025 --key legal.txt --legal-hold Status=ON

aws s3api list-object-versions --bucket object-lock-dgt-26062025

aws s3api delete-object --bucket object-lock-dgt-26062025 --key legal.txt --version-id UX4h5ajp3bHShC1gJKIpFwEV4Y.9IrSu

aws s3api put-object-legal-hold --bucket object-lock-dgt-26062025 --key legal.txt --legal-hold Status=OFF

aws s3api delete-object --bucket object-lock-dgt-26062025 --key legal.txt --version-id UX4h5ajp3bHShC1gJKIpFwEV4Y.9IrSu
