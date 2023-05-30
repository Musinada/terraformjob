packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210430"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "install-pre-install packages"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    expect_disconnect= true
    environment_vars = [
      "TEST=Installing pre-installation packeges",
    ]
    inline = [
      "echo Installing pre-installation packeges packages",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install git -y",
     "git clone https://github.com/bhagirathcloud/devops-automation.git",
      "cd devops-automation && bash packer.sh",
    ]
  }

  provisioner "shell" {
    inline = ["echo This provisioner runs last"]
  }
  provisioner "file" {
    source = "aws_credentials"
    destination = "/var/jenkins_home/aws_credentials"
  }
}
