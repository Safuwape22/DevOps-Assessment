provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = var.subnet1_availability_zone

  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = var.subnet2_availability_zone

  tags = {
    Name = var.subnet2_name
  }
}

resource "aws_security_group" "main" {
  vpc_id      = aws_vpc.main.id
  name        = var.sg_name
  description = var.sg_description

  ingress {
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = var.sg_ingress_cidr_blocks
  }

  egress {
    from_port   = var.sg_egress_from_port
    to_port     = var.sg_egress_to_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = var.sg_egress_cidr_blocks
  }
}

data "aws_ami" "ubuntu" {
  owners            = var.ami_owners
  most_recent       = true
  filter {
    name   = "name"
    values = var.ami_name
  }
  filter {
    name   = "virtualization-type"
    values = var.virtualization_type
  }
}

resource "aws_instance" "main" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.main.id]

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  ebs_block_device {
    device_name = var.ebs_device_name
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }

  user_data = var.user_data

  tags = {
    Name = var.instance_name
  }
}

