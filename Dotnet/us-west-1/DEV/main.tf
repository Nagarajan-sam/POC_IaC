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
  ingress_rules   = var.ingress_rules
  egress_rules    = var.egress_rules
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

#ALB 
module "alb" {
  source = "../../../modules/alb/"
    
  alb_name                       = var.alb_name
  internal                   = var.internal
  load_balancer_type         = var.load_balancer_type
  security_groups            = [module.security_group.security_group_id]
  subnets                    = module.vpc.public_subnet_ids[*]
  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout
  vpc_id                     = module.vpc.vpc_id
  http_listener              = var.http_listener
  https_listener             = var.https_listener
  target_group               = var.target_group
  health_check               = var.health_check
}