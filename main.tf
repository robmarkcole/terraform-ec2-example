terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "robins-dev-node" {
  name        = "robins-dev-node"
  description = "Robins dev Security Group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.large"
  security_groups = [aws_security_group.robins-dev-node.name]
  key_name        = "robins-ec2-key-pair"

  root_block_device {
    volume_size           = "30"
    delete_on_termination = true
  }

  tags = {
    Name = "Robin"
  }
}

# assign a constant IP that we can reach
resource "aws_eip" "tf" {
  instance = aws_instance.ec2.id
  vpc      = true

}