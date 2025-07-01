
## Create a new Bucket 
```sh
aws s3api create-bucket --bucket acl-example-dgt-01062025 --region us-east-1
```

## Turn of Block Public Access for ACLs
```sh
aws s3api put-public-access-block \
    --bucket acl-example-dgt-01062025 \
    --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

```sh
aws s3api get-public-access-block \
    --bucket acl-example-dgt-01062025
```

## Change Bucket Ownership
```sh
aws s3api put-bucket-ownership-controls \
--bucket acl-example-dgt-01062025 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```

## Change ACLs to allow for a user in another AWS Account
```sh
aws s3api put-bucket-acl 
--bucket acl-example-dgt-01062025 
--grant-full-control emailaddress=djibril@yopmail.com,emailaddress=thiandoum@yopmail.com 
--grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers
```

```sh
aws s3api put-bucket-acl \
--bucket acl-example-dgt-01062025 \
--access-control-policy file:///Users/djibrilgueyethiandoum/Developements/workspace-aws/aws-labs/s3/acl/policy.json

## Access bucket from other account