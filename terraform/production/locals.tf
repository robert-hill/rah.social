locals {
  name          = "mastodon-server-production"
  region        = "us-west-2"
  instance_type = "m5a.large"

  tags = {
    Terraform   = "true"
    Environment = "production"
    Site        = "rah.social"
  }

  fast_ttl = "30"
  slow_ttl = "300"
}