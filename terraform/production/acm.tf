module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = "rah.social"
  zone_id     = data.aws_route53_zone.this

  subject_alternative_names = [
    "*.rah.social"
  ]

  wait_for_validation = true

  tags = local.tags
}