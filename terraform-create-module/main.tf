# https://developer.hashicorp.com/terraform/tutorials/modules/module-create
# https://github.com/hashicorp/learn-terraform-modules-create
# https://stackoverflow.com/questions/76419099/access-denied-when-creating-s3-bucket-acl-s3-policy-using-terraform 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "thang-test-05-08-2023"
  index_name  = "index.html"
  error_name  = "error.html"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
