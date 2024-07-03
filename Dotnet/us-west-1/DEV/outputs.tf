output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.private_subnet_ids
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "s3_bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn
}
 
output "s3_bucket_id" {
  value = module.s3_bucket.s3_bucket_id
}

output "ec2_role_arn" {
  value = module.iam.ec2_role_arn
}

output "ec2_policy_arn" {
  value = module.iam.ec2_policy_arn
}

output "s3_role_arn" {
  value = module.iam.s3_role_arn
}

output "s3_policy_arn" {
  value = module.iam.s3_policy_arn
}

output "rds_role_arn" {
  value = module.iam.rds_role_arn
}

output "rds_policy_arn" {
  value = module.iam.rds_policy_arn
}