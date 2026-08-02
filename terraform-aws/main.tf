# AWS Resource - creating a s3 bucket
resource "aws_s3_bucket" "test_bucket" {
    bucket = "ravi.awscloudarchitect-2026" 
    # bucket name must be unique
    tags = {
      Name = "Learning bucket"
    }
}

resource "aws_s3_bucket_versioning" "verexample" {
  bucket = aws_s3_bucket.test_bucket.id
  versioning_configuration {
      status ="Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.test_bucket.id
  rule {
  apply_server_side_encryption_by_default {
    sse_algorithm = "AES256"
  }
  }
}