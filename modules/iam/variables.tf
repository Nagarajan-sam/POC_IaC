variable "rds_role_name" {
  description = "Name of the IAM role for RDS"
  type        = string
  default     = "rds-role"
}

variable "rds_policy_name" {
  description = "Name of the IAM policy for RDS"
  type        = string
  default     = "rds-policy"
}

variable "s3_role_name" {
  description = "Name of the IAM role for S3"
  type        = string
  default     = "s3-role"
}

variable "s3_policy_name" {
  description = "Name of the IAM policy for S3"
  type        = string
  default     = "s3-policy"
}

variable "ec2_role_name" {
  description = "Name of the IAM role for EC2"
  type        = string
  default     = "ec2-role"
}

variable "ec2_policy_name" {
  description = "Name of the IAM policy for EC2"
  type        = string
  default     = "ec2-policy"
}
