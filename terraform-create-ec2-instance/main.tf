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

resource "aws_instance" "demo_ec2_created_by_terraform" {
  ami           = "ami-0ed828ae690ef8b35"
  instance_type = "t2.micro"
}
