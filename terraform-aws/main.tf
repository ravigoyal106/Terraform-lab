# AWS Resource - creating a s3 bucket
resource "aws_s3_bucket" "test_bucket" {
    bucket = "ravi.awscloudarchitect-2026" 
    # bucket name must be unique
    tags = {
      Name = "Learning bucket"
      Environment = "Learning"
    }
}

resource "aws_s3_bucket_versioning" "verexample" {
  bucket = aws_s3_bucket.test_bucket.id
  versioning_configuration {
      status ="Enabled"
  }
}