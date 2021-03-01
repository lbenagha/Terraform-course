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
    Name = "Ebs-Ec2"
  }
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 10
  type            = "gp2"

  tags = {
    Name = "extra EBS volume data"
  }
}
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
}
