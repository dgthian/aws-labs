## Create a bucket

aws s3 mb s3://class-dgt-29062025

# Create file
echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://class-dgt-29062025 --storage-class STANDARD_IA

## CleanUp
aws s3 rm s3://class-dgt-29062025/hello.txt
aws s3 rb s3://class-dgt-29062025
