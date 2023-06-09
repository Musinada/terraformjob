terraform {
    backend "s3" {
    bucket = "musibkt2"
    key    = "key_terraform.tfstate"
    region = "ap-south-1"
  }
}

terraform {

  required_version = ">= 0.12"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "controller_linux" {
  ami                         = var.linux_ami_id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id = var.subnet
  key_name                    = "anil"
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = 60
    delete_on_termination = true
    encrypted = true
  }
  tags = {
    Name = "linuxec2-automation"
  }
}

output "instance_ip_linux_controller" {
  description = "The public ip for ssh access to linux controller"
  value       = aws_instance.controller_linux.public_ip
}

resource "aws_security_group" "anilSG2" {
  name        = "anilSG2"
  description = "Allows all traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
  tags = {
    Name = "anilSG2"
  }
}


output "securitygroup_id" {
  value = aws_security_group.anilSG2.id
}

resource "aws_network_interface_sg_attachment" "controller_sg_attachment" {
  security_group_id    = aws_security_group.anilSG2.id
  network_interface_id = aws_instance.controller_linux.primary_network_interface_id
}

