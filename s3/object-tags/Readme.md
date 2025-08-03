## Create a bucket

aws s3 mb s3://object-tags-3007

## Upload file

echo "Hello Wolrd" > hello.txt
aws s3 cp hello.txt s3://object-tags-3007/hello.txt

## Apply Object Tagging
aws s3api put-object-tagging \
    --bucket object-tags-3007 \
    --key hello.txt \
    --tagging '{"TagSet": [{ "Key": "hello", "Value": "world" }]}'

## Cleanup
aws s3 rm s3://object-tags-3007/hello.txt
aws s3 rb s3://object-tags-3007

