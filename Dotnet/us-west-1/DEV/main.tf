module "vpc" {
  source = "../../../global_modules/vpc/"

  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
}

#security_group
module "security_group" {
  source          = "../../../global_modules/security-group/"
  name            = var.name
  description     = var.description
  vpc_id          = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name = var.tags
  }
}

#EC2 instance
module "ec2_instance" {
  source                 = "../../../modules/ec2/"
  instance_name          = var.instance_name
  instance_type          = var.instance_type
  instance_key_name      = var.instance_key_name
  subnet_id              = module.vpc.public_subnet_ids[0]
  ami_id                 = var.ami_id
  security_group_ids     = [module.security_group.security_group_id]
}
