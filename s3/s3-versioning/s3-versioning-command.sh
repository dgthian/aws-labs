## Create a bucket without versioning
aws s3 mb s3://aws-s3-versioning-dgt-16072025

## Create unversioned 
echo "Hello wolrd" > myfile.txt

## copy the unversionined file to s3
aws s3 cp myfile.txt s3://aws-s3-versioning-dgt-16072025

## Show the contents of the s3 bucket notice s3 ls does not show versioning information
aws s3 ls s3://aws-s3-versioning-dgt-16072025

#Get a more detailed listing of the bucket, noticed it does not show versioning information 
aws s3api list-objects --bucket aws-s3-versioning-dgt-16072025 

# Get object version and see what happen on unversioned object
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt
## make that VersionId is null
## "VersionId": "null",

## Turn on versioning for our s3 bucket
aws s3api put-bucket-versioning --bucket aws-s3-versioning-dgt-16072025 --versioning-configuration Status=Enabled   

## Confirm bucket versioning is turned on via the cli
aws s3api get-bucket-versioning --bucket aws-s3-versioning-dgt-16072025
#{
#    "Status": "Enabled"
#}

# Check previous if it has version
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt

# Notice existing object the version is still null
# "VersionId": "null",

# lets update the file in order to apply versioning 
echo "Hello world version 1" > myfile.txt
## copy the updated file to s3
aws s3 cp myfile.txt s3://aws-s3-versioning-dgt-16072025

# Check if file now has version
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt
# it should have two versions:
# "VersionId": "jDy5UJmyiccCWjJrfRSRN.c3Te4hkzB7",
# "VersionId": "null",

#Update it again
echo "Hello world version 2" > myfile.txt
## copy the updated file to s3
aws s3 cp myfile.txt s3://aws-s3-versioning-dgt-16072025
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt --query Versions[].VersionId --output text
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt --query Versions[].VersionId --output table

# lets see the contents of the latest file
#note that we cannot use s3 cp to get specific version of file
# because its a high level s3 api
aws s3 cp s3://aws-s3-versioning-dgt-16072025/myfile.txt - | cat

# we can print out the contents of the s3 and get the versioning with s3api get-object
aws s3api get-object \
  --bucket aws-s3-versioning-dgt-16072025 \
  --key myfile.txt \
  --version-id null \
   /dev/stdout \
   | cat


# lets delete an object without specifying version id
#{
#    "DeleteMarker": true,
#    "VersionId": "z_j7OqjPzCKDG3Hhx5Va5yNQ8SIguwUS"
#}


# lets attempt to fetch object
aws s3api get-object --bucket aws-s3-versioning-dgt-16072025 
# this will return a 403 because the file is deleted

# get all object versions 
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt --output text
# make note there is delete marker
# make note that all versions are still there

# lets see if we can get the previous version which we technically deleted
aws s3api get-object --bucket aws-s3-versioning-dgt-16072025 --key myfile.txt --version-id B0p2djjYlOtMzj4hrroJwCu5ANlyb0fF /dev/stdout | cat

# lets bring back the last version by download it and reuploading it aka copy it back
aws s3api get-object --bucket aws-s3-versioning-dgt-16072025 --key myfile.txt --version-id B0p2djjYlOtMzj4hrroJwCu5ANlyb0fF --key myfile.txt myfile.txt
aws s3api put-object --bucket aws-s3-versioning-dgt-16072025 --key myfile.txt --key myfile.txt


# lets check the versions again
aws s3api list-object-versions --bucket aws-s3-versioning-dgt-16072025 --prefix myfile.txt

# Create an MFA Virtual Device under your user, We'll turn on MFA
# you need to attach MFA to root user
# you will need to generate access key for our root creadentials
#https://repost.aws/knowledge-center/s3-bucket-mfa-delete
aws s3api put-bucket-versioning --bucket aws-s3-versioning-dgt-16072025 --versioning-configuration MFADelete=Enabled,Status=Enabled --mfa "arn:aws:iam::816069170623:mfa/AuthyRoot 809939"


# Confirm that you sue root command
aws sts get-caller-identity
#{
#    "UserId": "816069170623",
#    "Account": "816069170623",
#    "Arn": "arn:aws:iam::816069170623:root"
#}

# Use the root user to disable MFA Delete
aws s3api put-bucket-versioning --bucket aws-s3-versioning-dgt-16072025 --versioning-configuration MFADelete=Disabled,Status=Enabled --mfa "arn:aws:iam::816069170623:mfa/AuthyRoot 386069"
