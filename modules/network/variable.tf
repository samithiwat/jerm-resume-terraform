# VPC Name
variable "vpc_name" {
  type        = string
  description = "VPC Name"
}
# AWS AZ
variable "aws_az" {
  type        = list(any)
  description = "List of AWS AZ"
}
# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
}

# Public Subnet Variables
variable "public_subnet_cidr" {
  type        = list(any)
  description = "List of CIDR for the public subnet"
}

# Private Subnet Variables
variable "private_subnet_cidr" {
  type        = list(any)
  description = "List CIDR for the private subnet"
}
