import boto3

# Initialize S3 client
s3 = boto3.client('s3', region_name='eu-west-1')  # Replace with your region

# Parameters
bucket_name = "s3-select-djibril-2907"
key = 'data.csv'
expression = 'SELECT * FROM S3Object LIMIT 6'

try:
    response = s3.select_object_content(
        Bucket=bucket_name,
        Key=key,
        ExpressionType='SQL',
        Expression=expression,
        InputSerialization={
            'CSV': {
                'FileHeaderInfo': 'USE'  # Change to 'NONE' if no header row
            }
        },
        OutputSerialization={
            'CSV': {}
        }
    )

    # Read and print results
    for event in response['Payload']:
        if 'Records' in event:
            print(event['Records']['Payload'].decode('utf-8'))

except Exception as e:
    print("S3 Select failed:", str(e))
