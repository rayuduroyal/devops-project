resource "aws_instance" "sample" {
  ami           = "ami-0855cab4944392d0a"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_sample.id, "sg-000e3d77edcfc8e1f"]

  tags = {
    Name = "sample"
  }
}