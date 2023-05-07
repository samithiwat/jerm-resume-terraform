variable "ec2_ami" {
  type = string
  description = "EC2 root AMI"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type for Linux Server"
  default     = "t2.micro"
}

variable "ec2_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}

variable "ec2_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Linux Server"
}

variable "ec2_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Linux Server."
  default     = "gp2"
}
