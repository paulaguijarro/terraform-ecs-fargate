# Improve: adding certificate to activate HTTPS listener:
# HTTP listener will redirects to the HTTPS listener, which sends traffic to the target group

resource "aws_lb" "this" {
  name                       = "${var.name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.alb_sg
  subnets                    = var.subnets.*.id
  enable_deletion_protection = false
}

resource "aws_alb_target_group" "this" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    protocol            = "HTTP"
    matcher             = "200"
    interval            = "60"
    healthy_threshold   = "3"
    unhealthy_threshold = "2"
    timeout             = "3"
    path                = var.healthcheck
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.this.id
  port              = 80
  protocol          = "HTTP"

  # default_action {
  #   type = "redirect"

  #   redirect {
  #     port        = 443
  #     protocol    = "HTTPS"
  #     status_code = "HTTP_301"
  #   }
  # }

  default_action {
    target_group_arn = aws_alb_target_group.this.id
    type             = "forward"
  }
}

# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_lb.this.id
#   port              = 443
#   protocol          = "HTTPS"

#   ssl_policy      = "ELBSecurityPolicy-2016-08"
#   certificate_arn = var.tls_cert_arn

#   default_action {
#     target_group_arn = aws_alb_target_group.this.id
#     type             = "forward"
#   }
# }
