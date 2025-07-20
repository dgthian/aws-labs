## Create a new bucket
aws s3 mb s3://lifecycle-dgt-18072025

# Create lifecycle policy configuration
aws s3api put-bucket-lifecycle --bucket lifecycle-dgt-18072025 --lifecycle-configuration file://lifecycle.json

## Cleanup
aws s3 rb s3://lifecycle-dgt-18072025