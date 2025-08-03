
require "aws-sdk-s3"
require "pry"
require 'stringio'
# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html

client = Aws::S3::Client.new
resp = client.get_object(bucket: 's3-select-djibril-2907', key: 'data.csv')
puts resp.body.read