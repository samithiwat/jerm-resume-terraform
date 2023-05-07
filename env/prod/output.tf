output "access_key" {
  value = module.security.s3_access_key
}

# Base64 encoded
output "access_key_secret" {
  value = module.security.s3_access_key_secret
}

output "network_vpc_id" {
  value = module.network.vpc_id
}

output "network_public_subnet_id" {
  value = module.network.public_subnet_id
}

output "network_private_subnet_id" {
  value = module.network.private_subnet_id
}

output "api_eip" {
  value = module.api.ec2_instance_eip
}

output "email_eip" {
  value = module.email.ec2_instance_eip
}

output "s3_arn" {
  value = module.s3.s3_arn
}

output "s3_iam_access_key" {
  value = module.security.s3_access_key
}

output "s3_iam_access_key_secret" {
  value = module.security.s3_access_key_secret
}

output "email_queue_url"{
  value = module.email_queue.queue_url
}

output "deadletter_queue_url"{
  value = module.email_queue.deadletter_queue_url
}