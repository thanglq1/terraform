# Variable for VPC
variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "dev-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zone for VPC"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "vpc_private_subnets" {
  description = "Private subnet for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnet for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_vpn_gateway" {
  description = "Enable VNP gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Variable for EC2
variable "ec2_name" {
  description = "Name for EC2"
  type        = string
  default     = "dev-ec2"
}

variable "ec2_instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.micro"
}

variable "ec2_tags" {
  description = "Tags to apply to resources created by EC2 module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}
