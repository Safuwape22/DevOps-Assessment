variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "VPC-ABCDEF"
}

variable "subnet1_cidr_block" {
  description = "The CIDR block for subnet1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet1_availability_zone" {
  description = "The availability zone for subnet1"
  type        = string
  default     = "us-west-1a"
}

variable "subnet1_name" {
  description = "The name of subnet1"
  type        = string
  default     = "Subnet-1234567"
}

variable "subnet2_cidr_block" {
  description = "The CIDR block for subnet2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnet2_availability_zone" {
  description = "The availability zone for subnet2"
  type        = string
  default     = "us-west-1c"
}

variable "subnet2_name" {
  description = "The name of subnet2"
  type        = string
  default     = "Subnet-7654321"
}

variable "sg_name" {
  description = "The name of the security group"
  type        = string
  default     = "allow_ssh"
}

variable "sg_description" {
  description = "The description of the security group"
  type        = string
  default     = "Allow SSH from specific IP range"
}

variable "sg_ingress_from_port" {
  description = "The starting port for ingress rules"
  type        = number
  default     = 22
}

variable "sg_ingress_to_port" {
  description = "The ending port for ingress rules"
  type        = number
  default     = 22
}

variable "sg_ingress_protocol" {
  description = "The protocol for ingress rules"
  type        = string
  default     = "tcp"
}

variable "sg_ingress_cidr_blocks" {
  description = "The CIDR blocks for ingress rules"
  type        = list(string)
  default     = ["10.72.100.0/24"]
}

variable "sg_egress_from_port" {
  description = "The starting port for egress rules"
  type        = number
  default     = 0
}

variable "sg_egress_to_port" {
  description = "The ending port for egress rules"
  type        = number
  default     = 0
}

variable "sg_egress_protocol" {
  description = "The protocol for egress rules"
  type        = string
  default     = "-1"
}

variable "sg_egress_cidr_blocks" {
  description = "The CIDR blocks for egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t3.large"
}

variable "root_volume_size" {
  description = "The size of the root volume"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "The type of the root volume"
  type        = string
  default     = "gp2"
}

variable "ebs_device_name" {
  description = "The device name for the additional EBS volume"
  type        = string
  default     = "/dev/sdh"
}

variable "ebs_volume_size" {
  description = "The size of the additional EBS volume"
  type        = number
  default     = 40
}

variable "ebs_volume_type" {
  description = "The type of the additional EBS volume"
  type        = string
  default     = "gp3"
}

variable "user_data" {
  description = "The user data to configure the instance"
  type        = string
  default     = <<-EOF
                #!/bin/bash
                apt-get update
                apt-get install -y unzip curl
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
                EOF
}

variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "web"
}

variable "ami_owners" {
  description = "The owners of the AMI"
  type        = list(string)
  default     = ["099720109477"]
}

variable "ami_name" {
  description = "The name of the AMI"
  type        = list(string)
  default     = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}

variable "virtualization_type" {
  description = "The virtualization type of the AMI"
  type        = list(string)
  default     = ["hvm"]
}
