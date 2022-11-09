resource "aws_route53_record" "apex" {
  name = data.aws_route53_zone.this.name
  type = "A"
  alias {
    evaluate_target_health = false
    name                   = aws_lb.mastodon.dns_name
    zone_id                = "Z18D5FSROUN65G"
  }
  zone_id = data.aws_route53_zone.this.zone_id
}