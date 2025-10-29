import boto3, os

endpoint = os.getenv("AWS_ENDPOINT")

s3_client = boto3.client(
    "s3",
    region_name="us-east-1", 
    endpoint_url="http://localhost:4566"
)
s3_client.create_bucket(Bucket="google.com")