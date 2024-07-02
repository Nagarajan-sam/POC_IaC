resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout

  tags = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.id
  port              = var.http_listener["port"]
  protocol          = var.http_listener["protocol"]

  default_action {
    type = "redirect"

    redirect {
      port        = var.http_listener["redirect"]["port"]
      protocol    = var.http_listener["redirect"]["protocol"]
      status_code = var.http_listener["redirect"]["status_code"]
    }
  }
}
/*
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.id
  port              = var.https_listener["port"]
  protocol          = var.https_listener["protocol"]
  ssl_policy        = var.https_listener["ssl_policy"]
  certificate_arn   = var.https_listener["certificate_arn"]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
*/
resource "aws_lb_target_group" "this" {
  name        = var.target_group["name"]
  port        = var.target_group["port"]
  protocol    = var.target_group["protocol"]
  target_type = var.target_group["target_type"]
  vpc_id      = var.vpc_id

  health_check {
    interval            = var.health_check["interval"]
    path                = var.health_check["path"]
    port                = var.health_check["port"]
    protocol            = var.health_check["protocol"]
    timeout             = var.health_check["timeout"]
    healthy_threshold   = var.health_check["healthy_threshold"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
  }

  tags = var.tags
}
