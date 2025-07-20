## Create a S3 Glacier file
aws s3 mb s3://s3-glacier-20072025

echo "Hello wolrd " > hello.txt 
aws s3 cp hello.txt s3://s3-glacier-20072025 --storage-class GLACIER

## Copy the fike
aws s3 cp s3://s3-glacier-20072025/hello.txt hello.txt
> This should fail because you have to restore the object

## Restore the Object

aws s3api restore-object \
    --bucket s3-glacier-20072025 \
    --key hello.txt \
    --restore-request Days=1