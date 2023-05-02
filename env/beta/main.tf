locals {
  production_availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  s3_bucket_name                = "s3-${var.app_name}-${var.app_environment}"
}

data "local_file" "pgp_key" {
  filename = var.pgp_key_path
}

module "security" {
  source = "../../modules/security"

  app_name        = var.app_name
  app_environment = var.app_environment

  pgp_key = data.local_file.pgp_key.content_base64

  s3_bucket_name = local.s3_bucket_name
}

module "network" {
  source = "../../modules/network"

  app_environment = var.app_environment
  app_name        = var.app_name

  aws_az              = local.production_availability_zones
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
}

module "api" {
  source = "../../modules/ec2"

  app_environment = var.app_environment
  app_name        = var.app_name

  ec2_ami                         = data.aws_ami.ubuntu-linux-2204.id
  ec2_instance_type               = var.api_instance_type
  ec2_associate_public_ip_address = var.api_associate_public_ip_address
  ec2_root_volume_size            = var.api_root_volume_size
  ec2_root_volume_type            = var.api_root_volume_type
  ec2_iam_instance_profile_name   = module.security.ec2_instance_profile_s3.name

  key_pair_name = module.security.key_pair_name


  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_id[0]
}

module "jerm" {
  source = "../../modules/ec2"

  app_environment = var.app_environment
  app_name        = var.app_name

  ec2_ami                         = data.aws_ami.ubuntu-linux-2204.id
  ec2_instance_type               = var.jerm_instance_type
  ec2_associate_public_ip_address = var.jerm_associate_public_ip_address
  ec2_root_volume_size            = var.jerm_root_volume_size
  ec2_root_volume_type            = var.jerm_root_volume_type
  ec2_iam_instance_profile_name   = module.security.ec2_instance_profile_s3.name

  key_pair_name = module.security.key_pair_name


  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_id[0]
}

module "email" {
  source = "../../modules/ec2"

  app_environment = var.app_environment
  app_name        = var.app_name

  ec2_ami                         = data.aws_ami.ubuntu-linux-2204.id
  ec2_instance_type               = var.email_instance_type
  ec2_associate_public_ip_address = var.email_associate_public_ip_address
  ec2_root_volume_size            = var.email_root_volume_size
  ec2_root_volume_type            = var.email_root_volume_type
  ec2_iam_instance_profile_name   = module.security.ec2_instance_profile_s3.name

  key_pair_name = module.security.key_pair_name


  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_id[0]
}

module "s3" {
  source = "../../modules/s3"

  app_environment = var.app_environment
  app_name        = var.app_name

  s3_bucket_name = local.s3_bucket_name
  s3_participant_arn = module.security.s3_user_arn
}

module "email_queue" {
  source = "../../modules/sqs"

  app_environment = var.app_environment
  app_name        = var.app_name

  queue_name             = var.email_queue_name
  deadletter_queue_name = "${var.email_queue_name}-deadletter"
}
