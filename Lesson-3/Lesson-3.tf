#----------------------------------------------------
# My Terraform
#
#Build WebServer during Bootstrap
#
#Made by Sergey Chopov
#----------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_webserver" {
  ami                         = "ami-06ee6255945a96aba"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.my_webserver.id]
  user_data_replace_on_change = true
  user_data                   = file("user_data.sh")

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Sergey Chopov"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First Security Group"


  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
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
