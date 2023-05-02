# S3 bucket name
variable "s3_bucket_name" {
    type = string
    description = "S3 bucket name"
}

# PGP key
variable "pgp_key" {
  type = string
  description = "PGP key base64 contents"
}
