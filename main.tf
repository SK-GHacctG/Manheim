#
# AWS account access needed; if not an authorized user in the account, 
# the access_key and Secret_key are needed
#
provider "aws" {
  region = var.myregion
  access_key = "value..."
  secret_key = "value ..."
}

# Backend definition
# Assuming the bucket, sktfstatebucket, is available.
terraform {
  required_version = ">= 0.13"

  backend "s3" {
    bucket = "sktfstatebucket"
    key    = "skproject1/terraform.tfstate"
    region = "us-east-1"
  }
}
