terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
  
  # S3 Backend for state storage with DynamoDB locking
  backend "s3" {
    bucket         = "hoitcs-terraform-state"
    key            = "workflow/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hoitcs-terraform-locks"
    encrypt        = true
  }
}

# Configure the AWS Provider to use a specific profile
provider "aws" {
  region  = "us-east-1"
}
