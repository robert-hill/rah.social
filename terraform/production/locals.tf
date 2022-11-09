locals {
  name   = "mastodon-server-production"
  region = "us-west-2"

  tags = {
    Terraform   = "true"
    Environment = "production"
    Site        = "rah.social"
  }
}