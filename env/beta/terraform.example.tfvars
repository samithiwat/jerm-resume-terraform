# Application Definition 
app_name        = "jerm-resume"
app_environment = "beta"

# Keypair
key_pair_name = "jerm-resume-keypair"

# Network
vpc_name            = "jerm-resume"
vpc_cidr            = "10.20.0.0/16"
public_subnet_cidr  = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
private_subnet_cidr = ["10.20.4.0/24", "10.20.5.0/24", "10.20.6.0/24"]

# API EC2
ec2_instance_type               = "t2.micro"
ec2_associate_public_ip_address = true
ec2_root_volume_size            = 20
ec2_root_volume_type            = "gp2"

# Jerm EC2
jerm_instance_type               = "t2.micro"
jerm_associate_public_ip_address = true
jerm_root_volume_size            = 20
jerm_root_volume_type            = "gp2"

# Jerm EC2
email_instance_type               = "t2.micro"
email_associate_public_ip_address = true
email_root_volume_size            = 20
email_root_volume_type            = "gp2"
