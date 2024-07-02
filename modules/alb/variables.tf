variable "alb_name" {
  description = "The name of the load balancer."
  type        = string
}

variable "internal" {
  description = "If true, the load balancer will be internal."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create."
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ALB."
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ALB."
  type        = list(string)
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
}

variable "https_listener" {
  description = "HTTPS listener configuration."
  type = object({
    port            = number
    protocol        = string
    ssl_policy      = string
    certificate_arn = string
  })
  default           = null
}

variable "target_group" {
  description = "Target group configuration."
  type = object({
    name        = string
    port        = number
    protocol    = string
    target_type = string
  })
}

variable "vpc_id" {
  description = "The VPC ID where the ALB and target group will be deployed."
  type        = string
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
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
