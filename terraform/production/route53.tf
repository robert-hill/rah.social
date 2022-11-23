resource "aws_route53_record" "apex" {
  name    = data.aws_route53_zone.this.name
  type    = "A"
  ttl     = local.fast_ttl
  records = ["34.212.26.129"]
  zone_id = data.aws_route53_zone.this.zone_id
}

# Mail Records
resource "aws_route53_zone" "mail" {
  name = "mail.rah.social"
}

resource "aws_route53_record" "mail_delegation" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "mail.rah.social"
  type    = "NS"
  ttl     = local.fast_ttl
  records = aws_route53_zone.mail.name_servers
}

resource "aws_route53_record" "mail_txt" {
  zone_id = aws_route53_zone.mail.zone_id
  name    = aws_route53_zone.mail.name
  type    = "TXT"
  ttl     = local.fast_ttl
  records = [
    "v=spf1 include:mailgun.org ~all"
  ]
}

resource "aws_route53_record" "mail_mx" {
  zone_id = aws_route53_zone.mail.zone_id
  name    = aws_route53_zone.mail.name
  type    = "MX"
  ttl     = local.fast_ttl
  records = [
    "10 MXA.MAILGUN.ORG",
    "10 MXB.MAILGUN.ORG"
  ]
}

resource "aws_route53_record" "mail_meta" {
  zone_id = aws_route53_zone.mail.zone_id
  name    = "email.${aws_route53_zone.mail.name}"
  type    = "CNAME"
  ttl     = local.fast_ttl
  records = [
    "mailgun.org"
  ]
}