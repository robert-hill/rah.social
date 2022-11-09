locals {
  name          = "mastodon-server-production"
  region        = "us-west-2"
  instance_type = "t3a.micro"

  tags = {
    Terraform   = "true"
    Environment = "production"
    Site        = "rah.social"
  }
}