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