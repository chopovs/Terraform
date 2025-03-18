provider "aws" {}



resource "aws_instance" "my_ubuntu" {
  ami           = "ami-07eef52105e8a2059"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Sergey Chopov"
    Project = "Terraform Lessons"
  }
}
