resource "aws_ses_domain_identity" "email" {
  domain = var.ses_domain
}
