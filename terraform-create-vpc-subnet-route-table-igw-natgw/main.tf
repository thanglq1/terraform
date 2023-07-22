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

# Create VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_thang"
  }
}

# Create public subnet 1
resource "aws_subnet" "subnet_public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = "true" # Specify true to indicate that instances launched into the subnet should be assigned a public IP address

  tags = {
    Name = "subnet_public_1_thang"
  }
}

# Create public subnet 2
resource "aws_subnet" "subnet_public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = "true" # Specify true to indicate that instances launched into the subnet should be assigned a public IP address

  tags = {
    Name = "subnet_public_2_thang"
  }
}

# Create private subnet
resource "aws_subnet" "subnet_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = "false" # Private subnet so need set false

  tags = {
    Name = "subnet_private_thang"
  }
}

# Create NAT gatway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_public_1.id # NAT gatway need public ip
  depends_on    = [aws_internet_gateway.igw]
}

# Create igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw_thang"
  }
}

# Create route table public and private
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route_table_public_thang"
  }
}

resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "route_table_private_thang"
  }
}

# Create route table associate with public and private subnet
resource "aws_route_table_association" "associate_subnet_public_1" {
  subnet_id      = aws_subnet.subnet_public_1.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "associate_subnet_public_2" {
  subnet_id      = aws_subnet.subnet_public_2.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "associate_subnet_private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_private.id

}

# Creating EC2 instances in public and private subnet
resource "aws_instance" "ec2_public_subnet_1" {
  ami           = "ami-0ed828ae690ef8b35"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_public_1.id

  tags = {
    Name = "ec2_public_subnet_1"
  }
}

resource "aws_instance" "ec2_public_subnet_2" {
  ami           = "ami-0ed828ae690ef8b35"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_public_2.id

  tags = {
    Name = "ec2_public_subnet_2"
  }
}

resource "aws_instance" "ec2_private" {
  ami           = "ami-0ed828ae690ef8b35"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_private.id

  tags = {
    Name = "ec2_private"
  }
}
