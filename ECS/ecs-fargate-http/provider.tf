provider "aws" {
  region    = "us-east-1"
  # version = "5.29.0"
  
}

terraform {
  backend "s3" {
    bucket = "terrafom-backend-1"
    dynamodb_table = "state_lock"
    key = "terraform/ecs-fargate/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  } 
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }
}
