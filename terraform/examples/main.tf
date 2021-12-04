provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sample" {
  ami           = "ami-0855cab4944392d0a"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_sample.id, "sg-000e3d77edcfc8e1f"]

  tags = {
    Name = "sample"
  }
}

resource "aws_security_group" "allow_sample" {
  name        = "allow_sample"
  description = "Allow sample traffic"

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "allow_sample"
  }
}

