module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "rah-social-${local.name}"
  acl    = "private"

  versioning = {
    enabled = true
  }
}

module "s3_user" {
  source = "cloudposse/iam-s3-user/aws"
  version     = "1.0.0"

  s3_actions   = ["s3:*"]
  s3_resources = "${module.s3_bucket.arn}/*"
}