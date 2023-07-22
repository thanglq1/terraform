# Tutorial: https://developer.hashicorp.com/terraform/tutorials/configuration-language/locals

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

locals {
  tag_name = "${var.project_name} - ${var.environment}"
}

# Create EC2
resource "aws_instance" "demo_ec2_created_by_terraform" {
  ami           = "ami-0ed828ae690ef8b35"
  instance_type = "t2.micro"

  tags = {
    # If don't have locals, "${var.project_name} - ${var.environment}" is duplicate in your code 
    # Name = "${var.project_name} - ${var.environment}"
    Name = local.tag_name
  }
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    # If don't have locals, "${var.project_name} - ${var.environment}" is duplicate in your code 
    # Name = "${var.project_name} - ${var.environment}"
    Name = local.tag_name
  }
}

