module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = local.name

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = local.instance_type
  key_name               = "console"
  monitoring             = true
  vpc_security_group_ids = module.vpc.default_security_group_id
  subnet_id              = module.vpc.subnet_id

  tags = local.tags
}