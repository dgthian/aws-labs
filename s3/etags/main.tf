terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}
 
 provider "aws" {
  # Configuration options
 }

 resource "aws_s3_bucket" "default" {
 }
 
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.default.id 
    # The ETag is a hash of the object content, which can be used to verify integrity.
  key    = "myfile.txt"
  source = "myfile.txt" 
  etag = file("myfile.txt") # This is the ETag of the object
}