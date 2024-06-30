Given the existing infrastructure in the diagram, create a Terraform
configuration that will deploy a t3.large instance to us-east-1 in subnet-1234567
with the latest Ubuntu 22.04 LTS AMI. There should be an additional 40 GiB gp3
volume attached to the instance. A security group should also be created that
allows SSH from 10.72.100.0/24. The instance should have the latest version of the
AWS CLI installed.


----Solution----

1.	To execute the following Terraform configuration I created, start by running "terraform init" to initialize the backend and download provider plugins. Next, validate the configuration with "terraform validate" and preview the resources to be provisioned or changed with "terraform plan." Finally, apply the configuration using terraform apply. Kindly refer to the configuration. Below is the hard coded version of the terraform code. I prepared a version of the code that is not hard-coded as well. Hard-coding is never recommended because it renders the coded not re-usable and for security purposes. I do not hard code; However, I prepared both for you to view and execute. 

#Below is the hard-coded version of the requested terraform configuration with comments.

provider "aws" {
  region = "us-east-1" # As specified
}
#This represents VPC-ABCDEF
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC-ABCDEF"
  }
}
# This represents "Subnet-1234567"
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-1234567"
  }
}
#This represents "Subnet-7654321"
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet-7654321"
  }
}
# As specified
resource "aws_security_group" "ssh" {
  vpc_id      = aws_vpc.main.id
  name        = "allow_ssh"
  description = "Allow SSH from specific IP range"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.72.100.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-sg"
  }
}

# This will fetch the latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.large" # As specified
  subnet_id     = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.ssh.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp2" 
  }
# Additional volume
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 40 # As specified in the assessment
    volume_type = "gp3" # As specified in the assessment
  }
# This bootstrap will fetch the latest AWS cli as you requested in question 1
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y unzip curl
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install
              EOF

  tags = {
    Name = "Latest AWS cli Installation"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "security_group_id" {
  value = aws_security_group.ssh.id
}

output "instance_id" {
  value = aws_instance.web.id
}
