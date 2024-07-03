variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "dotnet-app-vpc"
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

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
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
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
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


#ALB
variable "alb_name" {
  description = "The name of the load balancer."
  type        = string
  default     = "dotnet-alb"
}

variable "internal" {
  description = "If true, the load balancer will be internal."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create."
  type        = string
  default     = "application"
}

variable "enable_deletion_protection" {
  description = "If true, deletion protection will be enabled on the ALB."
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "http_listener" {
  description = "HTTP listener configuration."
  type = object({
    port     = number
    protocol = string
    redirect = object({
      port        = string
      protocol    = string
      status_code = string
    })
  })
  default = {
    port     = 80
    protocol = "HTTP"
    redirect = {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

variable "https_listener" {
  description = "HTTPS listener configuration."
  type = object({
    port            = number
    protocol        = string
    ssl_policy      = string
    certificate_arn = string
  })
  default = null
}

variable "target_group" {
  description = "Target group configuration."
  type = object({
    name        = string
    port        = number
    protocol    = string
    target_type = string
  })
  default = {
    name        = "my-target-group"
    port        = 80
    protocol    = "HTTP"
    target_type = "instance"
  }
}

variable "health_check" {
  description = "Health check configuration for the target group."
  type = object({
    interval            = number
    path                = string
    port                = string
    protocol            = string
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
  })
  default = {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

#S3 Bucket
variable "bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
  default     = "dotnet-s3-bucket"
}

variable "acl" {
  type = string
  description = "Bucket ACL"
  default = null
}

variable "grant" {
  description = "An ACL policy grant. Conflicts with `acl`"
  type        = any
  default     = []
}
 
variable "create_object" {
  type = bool
  description = "Enable Objects in Bucket"
  default = false
}

variable "key" {
  type = string
  description = "Bucket folder structure"
  default = false
}

#RDS Instance
variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
  default     = "dotnet-app"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "8.0.35"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.m6g.large"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 200
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
  default     = "io2"
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3`"
  type        = number
  default     = 3000
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = "Master#123"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "dotnet"
}

variable "db_subnet_group_name" {
  description = "List of VPC subnet ids to associate"
  type        = string
  default     = "dotnet-subnet"
}

variable "skip_final_snapshot" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = bool
  default     = true
}