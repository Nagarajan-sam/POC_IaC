variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "my-vpc"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones to use for subnets."
  type        = list(string)
  default     = ["us-west-1b", "us-west-1c"]
}

#security_group

variable "name" {
  description = "The name of the security group"
  type        = string
  default     = "my-security-group"
}

variable "description" {
  description = "The description of the security group"
  type        = string
  default     = "My security group"
}

variable "tags" {
  description = "A map of tags to add to the security group"
  type        = string
  default     = "my-security-group"
}

#EC2 instance
variable "instance_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "dotnet-app"
}

variable "instance_type" {
  description = "Instance Type To Use"
  type        = string
  default     =  "t2.micro"
}

variable "instance_key_name" {
  description = "Instance Key Name to Inject to Instances"
  type        = string
  default     = "ec2-key"
}

variable "ami_id" {
  description = "Image Id we will use with servers"
  type        = string
  default     = "ami-08012c0a9ee8e21c4"
}
