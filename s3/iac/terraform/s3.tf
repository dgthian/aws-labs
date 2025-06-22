resource "aws_s3_bucket" "djibril-bucket-terraform" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}