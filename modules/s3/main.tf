resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.app_environment
  }
}

resource "aws_s3_bucket_acl" "s3-bucket" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl    = "private"
}
