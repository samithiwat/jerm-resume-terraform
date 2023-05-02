# Create Elastic IP for the EC2 instance
resource "aws_eip" "ec2-eip" {
  vpc = true
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-eip"
    Environment = var.app_environment
  }
}

# Create EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  iam_instance_profile = var.ec2_iam_instance_profile_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.aws-ec2-sg.id]
  key_name               = var.key_pair_name
  user_data              = file("../../modules/ec2/bootstrap.sh")

  # root disk
  root_block_device {
    volume_size           = var.ec2_root_volume_size
    volume_type           = var.ec2_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-server"
    Environment = var.app_environment
  }
}

# Associate Elastic IP to EC2 Server
resource "aws_eip_association" "ec2-eip-association" {
  instance_id   = aws_instance.ec2_instance.id
  allocation_id = aws_eip.ec2-eip.id
}
