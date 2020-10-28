terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

# variable "ami_component" {}
variable "region" {}

data "aws_ami" "selected" {
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }

  most_recent = true
}

resource "aws_instance" "instance" {
  ami           = "${data.aws_ami.selected.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}