resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.app_environment
  }
}

resource "aws_s3_bucket_acl" "s3-bucket" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "s3-bucket" {
  bucket = aws_s3_bucket.s3-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
