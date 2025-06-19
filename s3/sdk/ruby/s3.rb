# Required gems
require 'aws-sdk-s3'      # AWS SDK for accessing S3
require 'pry'             # Debugging tool (optional)
require 'securerandom'    # To generate UUIDs

# Configuration
bucket_name = ENV['BUCKET_NAME']    # The bucket name is read from environment variable
region = "eu-west-1"                # AWS region for the bucket
puts "Target bucket: #{bucket_name}"

# Initialize S3 client (uses default credentials/config)
client = Aws::S3::Client.new(region: region)

# Create the bucket in the specified region
# Note: S3 requires a location constraint when creating a bucket outside "us-east-1"
begin
  resp = client.create_bucket({
    bucket: bucket_name,
    create_bucket_configuration: {
      location_constraint: region
    }
  })
  puts "Bucket '#{bucket_name}' created successfully in region '#{region}'."
rescue Aws::S3::Errors::BucketAlreadyOwnedByYou
  puts "Bucket '#{bucket_name}' already exists and is owned by you."
end

# Generate a random number of objects to upload (between 1 and 6)
number_of_objects = 1 + rand(6)
puts "Number of objects to upload: #{number_of_objects}"

# Upload loop
number_of_objects.times do |i|
  puts "Uploading object ##{i + 1}"

  # Generate a filename and content
  filename = "file-#{i}.txt"
  output_path = "/tmp/#{filename}"

  # Write a UUID to the file
  File.open(output_path, 'w') do |file|
    file.write(SecureRandom.uuid)
  end

  # Upload the file to S3
  File.open(output_path, 'r') do |file|
    client.put_object({
      bucket: bucket_name,
      key: filename,
      body: file
    })
    puts "Uploaded #{filename} to bucket #{bucket_name}"
  end
end
