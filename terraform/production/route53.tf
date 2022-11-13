resource "aws_route53_record" "apex" {
  name = data.aws_route53_zone.this.name
  type = "A"
  ttl  = local.fast_ttl
  records = [
    aws_eip.rah_social.carrier_ip
  ]
  zone_id = data.aws_route53_zone.this.zone_id
}