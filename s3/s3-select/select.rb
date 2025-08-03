require "aws-sdk-s3"
# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html

client = Aws::S3::Client.new(region: "eu-west-1")

resp = client.select_object_content(
  bucket: "s3-select-djibril-2907",
  key: "data.csv",
  expression: "SELECT * FROM S3Object LIMIT 10",
  expression_type: "SQL",
  input_serialization: {
    csv: { file_header_info: "USE" }
  },
  output_serialization: {
    csv: {}
  }
)
 