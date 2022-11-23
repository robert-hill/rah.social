resource "aws_route53_record" "apex" {
  name    = data.aws_route53_zone.this.name
  type    = "A"
  ttl     = local.fast_ttl
  records = ["52.34.151.162"]
  zone_id = data.aws_route53_zone.this.zone_id
}

# Mail Records
resource "aws_route53_zone" "mail" {
  name = "mail.rah.social"
}

resource "aws_route53_record" "mail_delegation" {
  zone_id = data.aws_route53_zone.this
  name    = "mail.rah.social"
  type    = "NS"
  ttl     = local.fast_ttl
  records = [
    aws_route53_zone.mail.name_servers
    ]
}