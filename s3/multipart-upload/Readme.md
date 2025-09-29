## Create Large file
```sh
cd /Users/djibrilgueyethiandoum/Developements/workspace-aws/aws-labs/s3/multipart-upload
dd if=/dev/zero of=largefile.txt bs=1M count=50
ls -la -h | grep large
```

## Create a new bucket
```sh
aws s3 mb s3://multipart-upload-26092025
```

## Initiate
```sh
aws s3api create-multipart-upload --bucket multipart-upload-26092025 --key 'largefile.txt'
```

## List multipart uploads
```sh
aws s3api list-multipart-uploads --bucket multipart-upload-26092025 --query Uploads[].UploadId
```

> Remember to greb the upload id:
> eg: "UploadId": "ElItVeVe5eOSUgce1k1cLhYUKBJ3lIx8qV5lip5CJdl4SE_ZlxbEOGnKBoZ..2K5KWwWvwF6VQ7fnSPmmvnI0kNdnfkzJwKeu0o4iDp29jQhcaahgbIF3GhjnkP_WH8d"

## Split file into parts
```sh   
split -b 10M -d largefile.txt part- 
ls -la -h | grep part
```

## Upload part
export UPLOAD_ID="ElItVeVe5eOSUgce1k1cLhYUKBJ3lIx8qV5lip5CJdl4SE_ZlxbEOGnKBoZ..2K5KWwWvwF6VQ7fnSPmmvnI0kNdnfkzJwKeu0o4iDp29jQhcaahgbIF3GhjnkP_WH8d"
export BUCKET=multipart-upload-26092025

env | grep UPLOAD_ID

aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 1 --body part-00 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 2 --body part-01 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 3 --body part-02 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 4 --body part-03 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 5 --body part-04 --upload-id $UPLOAD_ID

## Get all the parts with their etags
aws s3api list-parts --bucket $BUCKET --key 'largefile.txt' --upload-id $UPLOAD_ID --query "Parts[].{PartNumber: PartNumber, Etag: ETag}" > parts.json

## Finish
aws s3api complete-multipart-upload --multipart-upload file://parts.json --bucket $BUCKET --key 'largefile.txt' --upload-id $UPLOAD_ID

## Cleanup
aws s3 rb s3://$BUCKET/largefile.txt
aws s3 rb s3://$BUCKET
rm largefile.txt part-*