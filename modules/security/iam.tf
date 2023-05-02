resource "aws_iam_user" "s3-user" {
  name               = var.s3_bucket_name
  tags = {
    Name        = var.s3_bucket_name
    Environment = var.app_environment
  }
}

resource "aws_iam_access_key" "s3-user" {
  user = aws_iam_user.s3-user.name
}

resource "aws_iam_user_policy" "s3-user" {
  name   = "${var.s3_bucket_name}-policy"
  user   = aws_iam_user.s3-user.name
  policy = data.aws_iam_policy_document.s3-user.json
}

resource "aws_iam_role" "s3-user" {
  name               = "${var.s3_bucket_name}-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.s3-user-role.json
}

resource "aws_iam_role_policy" "s3-user" {
  name = "${var.s3_bucket_name}-policy"
  role = aws_iam_role.s3-user.id
  policy = data.aws_iam_policy_document.s3-user.json
}

resource "aws_iam_instance_profile" "s3-user" {
  name = "${var.s3_bucket_name}-instance-profile"
  role = aws_iam_role.s3-user.name
}
