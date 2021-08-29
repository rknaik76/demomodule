terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws" 
      }
    }
  
}

provider "aws" {
    region = "us-east-1"
}

variable "instancename" {
  type = string
}

variable "instancetype" {
  type = string
}

data "aws_ami" "ubuntu" {
  owners = ["099720109477"]
  most_recent      = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "myserver001" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instancetype
 
  tags = {
    "Name" = var.instancename
  }

  key_name = "ranjit"
}

output "ip_address" {
  value = aws_instance.myserver001.public_ip
}
