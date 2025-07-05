## Create a bucket
```sh
aws s3 mb s3://cors-dgt-04062025
```

## Change block public access
```sh
aws s3api put-public-access-block \
    --bucket cors-dgt-04062025 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```
## Create a bucket policy
aws s3api put-bucket-policy --bucket cors-dgt-04062025 --policy file://bucket-policy.json


## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket cors-dgt-04062025 --website-configuration file://website.json
```

## Uploading our index.html file and include a resource that would be cross origin 
```sh
aws s3 cp index.html s3://cors-dgt-04062025
```

## View the website and see if the index.html is there
Some regions use hyphen
http://cors-dgt-04062025.s3-website-eu-west-1.amazonaws.com

http://cors-dgt-04062025.s3-website.eu-west-1.amazonaws.com

## Create Website 2
```sh
aws s3 mb s3://cors-dgt-05072025
```
## Change block public access
```sh
aws s3api put-public-access-block \
    --bucket cors-dgt-05072025 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```
## Create a bucket policy
```sh
aws s3api put-bucket-policy --bucket cors-dgt-05072025 --policy file://bucket-policy-2.json
```

## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket cors-dgt-05072025 --website-configuration file://website.json
```

## Upload our javascript file
```sh
aws s3 cp hello.js s3://cors-dgt-05072025
```

## Create API Gateway with mock response and then test endpoint
```sh 
curl -X POST https://vmqx9ma038.execute-api.us-east-1.amazonaws.com/prod/hello \
  -H "Content-Type: application/json" \
  -d '{}'
```

## Set CORS on our bucket

```sh
aws s3api put-bucket-cors --bucket cors-dgt-04062025 --cors-configuration file://cors.json
```

