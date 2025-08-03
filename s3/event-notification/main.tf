terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.6.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket_notification" "default" {
    bucket = aws_s3_bucket.default.id
    eventbridge = true  
}

resource "aws_s3_bucket" "default" {
 #bucket name will randomly generated
}

output "s3_bucket_name" {
  value = aws_s3_bucket.default.id
}