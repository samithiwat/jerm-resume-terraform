# Application
variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_environment" {
  type        = string
  description = "Application environment"
}

# Security
variable "pgp_key_path" {
  type        = string
  description = "PGP key path"
}

# Network
variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
}

variable "public_subnet_cidr" {
  type        = list(any)
  description = "List of CIDR for the public subnet"
}

variable "private_subnet_cidr" {
  type        = list(any)
  description = "List of CIDR for the private subnet"
}

# API 
variable "api_instance_type" {
  type        = string
  description = "EC2 instance type for API's Server"
  default     = "t2.micro"
}

variable "api_instance_name" {
  type        = string
  description = "EC2 instance name for API's Server"
}

variable "api_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the API's EC2 instance"
  default     = true
}

variable "api_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of API's Server"
}

variable "api_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of API's Server."
  default     = "gp2"
}

# Email Service
variable "email_instance_type" {
  type        = string
  description = "EC2 instance type for Email's Server"
  default     = "t2.micro"
}

variable "email_instance_name" {
  type        = string
  description = "EC2 instance name for Email's Server"
}

variable "email_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the Email EC2 instance"
  default     = true
}

variable "email_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Email's Server"
}

variable "email_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Email's Server."
  default     = "gp2"
}

# Email Queue
variable "email_queue_name" {
  type        = string
  description = "Email queue name."
  default     = "jerm-email-queue"
}
