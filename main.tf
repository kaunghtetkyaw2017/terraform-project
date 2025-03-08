terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
  }

}

provider "aws" {
  region = "eu-west-2"
}

locals {
  server_name = var.server_config.name
  server_type = var.server_config.type

  anywhere     = "0.0.0.0/0"
  all_ports    = "-1"
  ssh_port     = 22
  tcp_protocol = "tcp"

  http_port = 80

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "nginx-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.server_config.type
  tags = {
    Name = var.server_config.name
  }

  vpc_security_group_ids = [
    aws_security_group.nginx-sg.id
  ]

  user_data = templatefile("./config/run.sh.tmpl", {
  })

  user_data_replace_on_change = true
}

