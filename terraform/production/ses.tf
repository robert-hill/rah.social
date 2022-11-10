resource "aws_ses_domain_identity" "ses_domain" {
  domain = data.aws_route53_zone.this.name
}

resource "aws_ses_domain_mail_from" "main" {
  domain           = aws_ses_domain_identity.ses_domain.domain
  mail_from_domain = "mail.${data.aws_route53_zone.this.name}"
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = join("", aws_ses_domain_identity.ses_domain.*.domain)
}