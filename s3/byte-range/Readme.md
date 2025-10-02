## Create a bucket
aws s3 mb s3://byte-range-30092025

## Upload our file 
aws s3api put-object --bucket byte-range-30092025 --key hello.txt --body file://hello.txt

## Get an Object range of bytes
aws s3api get-object --bucket byte-range-30092025 --key hello.txt --range bytes=0-6 hello-partial.txt

## Clean up
aws s3 rb s3://byte-range-30092025