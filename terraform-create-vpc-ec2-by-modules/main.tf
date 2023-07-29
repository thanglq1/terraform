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

# Create VPC https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0?product_intent=terraform
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  enable_vpn_gateway = var.vpc_enable_vpn_gateway

  tags = var.vpc_tags
}

# Create EC2 https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_name

  instance_type          = var.ec2_instance_type
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = var.ec2_tags
}
