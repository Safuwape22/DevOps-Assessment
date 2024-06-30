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
  value = aws_security_group.main.id
}

output "instance_id" {
  value = aws_instance.main.id
}

output "ami_id" {
  value = data.aws_ami.ubuntu.id
}

