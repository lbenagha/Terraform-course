resource "aws_instance" "example" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"

# for VPC subnet
  subnet_id = aws_subnet.main-public-1.id

# for Public key
  key_name      = var.key_name

# for Sg
  security_groups        = [aws_security_group.allow-ssh-login.id]

  tags = {
    Name = "example-test-EC2_VPC"
  }
}
