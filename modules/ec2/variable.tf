# VPC id
variable "vpc_id" {
  type = string
  description = "VPC id"
}

# EC2 subnet id
variable "subnet_id" {
  type = string
  description = "EC2 subnet id"
}

# EC2 keypair name
variable "key_pair_name" {
  type = string
  description = "EC2 keypair name"
}

# EC2 instance profile
variable "ec2_iam_instance_profile_name" {
  type = string
  description = "EC2 instance profile"
}
