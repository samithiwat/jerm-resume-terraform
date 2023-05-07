#####################################
## Virtual Machine Module - Output ##
#####################################

output "ec2_instance_id" {
  value = aws_instance.ec2_instance.id
}

output "ec2_instance_public_dns" {
  value = aws_instance.ec2_instance.public_dns
}

output "ec2_instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "ec2_instance_private_ip" {
  value = aws_instance.ec2_instance.private_ip
}

output "ec2_instance_eip" {
  value = aws_eip.ec2-eip.public_ip
}

output "ec2_security_group_id" {
  value = aws_security_group.aws-ec2-sg.id
}
