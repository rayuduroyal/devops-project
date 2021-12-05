resource "aws_instance" "sample" {
  count                  = length(var.name)
  ami                    = "ami-0855cab4944392d0a"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.SGID]

  tags = {
    Name = element(var.name, count.index)
  }
}

variable "SGID" {}
variable "name" {}


