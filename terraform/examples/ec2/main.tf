resource "aws_instance" "sample" {
  ami           = "ami-0855cab4944392d0a"
  instance_type = "t3.micro"
  vpc_security_group_ids = []

  tags = {
    Name = "sample"
  }
}