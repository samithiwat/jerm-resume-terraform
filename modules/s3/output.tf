output "s3_arn" {
  value = aws_s3_bucket.s3-bucket.arn
}

output "s3_domain_name"{
    value = aws_s3_bucket.s3-bucket.bucket_domain_name
}
