# User id
output "s3_user_id" {
  value = aws_iam_user.s3-user.id
}

# User ARN
output "s3_user_arn" {
  value = aws_iam_user.s3-user.arn
}

# Access key
output "s3_access_key" {
  value = aws_iam_access_key.s3-user.id
}

# Base64 encoded secret
output "s3_access_key_secret" {
    value = aws_iam_access_key.s3-user.encrypted_secret
}

output "ec2_instance_profile_s3"{
  value = aws_iam_instance_profile.s3-user
}
