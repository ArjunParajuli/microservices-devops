provider "aws" {
  region = "us-west-2"
}

# S3 Bucket for Remote Backend (State Storage)
resource "aws_s3_bucket" "terraform_state" {
  bucket = "arzunn-demo-terraform-eks-state-s3-bucket"  

  lifecycle {
    prevent_destroy = false  # allows deletion of resource (default val)
  }
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-eks-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}