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

resource "aws_route53_record" "dkim" {
  zone_id = aws_route53_zone.mail.zone_id
  name    = "k1._domainkey.${aws_route53_zone.mail.name}"
  type    = "TXT"
  ttl     = local.fast_ttl
  records = [
    "k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuH6kj5u/LwSyd/tr",
    "cjt17rPJF5XmrGkK8zjFCoXmhWlKl2uCo9HT18sdEcJf5zW6YFqtyYbuQ",
    "8dafCyv8eUJecSO/wocDJtpui3x5D28jyKBff8o/ZgbySq+DiYw",
    "e80RR8MoUgtrZ8TpAotzmZE8mX0aQYDn4IO03my0M7w/fk7/iwO7B1Uwb6ik9",
    "Mf4JO4sioOHFzBwR0WmWTlH5muF6m9KxYgSfKX1UjDpCTKGQ9uwl6QrV1+B",
    "tmy6v7s7EYib6ZFMkkj+v0QizGq/N9NcB2iaIcn2uU+whad/Xz0UQNyXhSdZdcXyah",
    "KdZ2PYNu9k1rBT8r+F73g+hbsKRkp7SwIDAQAB"
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