# Terraform block

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

# Setting aws region 
provider "aws" {
  region = "ap-south-1"
}

# AWS Resource - creating a s3 bucket
resource "aws_s3_bucket" "test_bucket" {
    bucket = "ravi.awscloudarchitect-2026" 
    # bucket name must be unique
}