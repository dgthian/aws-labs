## Create a bucket

aws s3 mb s3://metadata-dgt-26062025

### Create a new file
echo "Hello Djibril "> hello.txt

## Upload file with metada
aws s3api put-object --bucket metada-dgt-26062025 --key hello.txt --body hello.txt --metadata KeyName1=Gueye

## Get Metadata through head object

aws s3api head-object --bucket metada-dgt-26062025 --key hello.txt


## Cleanup
aws s3 rm s3://metada-dgt-26062025 --recursive
aws s3 rb s3://metada-dgt-26062025 