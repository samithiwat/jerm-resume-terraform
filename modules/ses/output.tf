output "ses_verify_token" {
  value = aws_ses_domain_identity.ses_domain_identity.verification_token
}