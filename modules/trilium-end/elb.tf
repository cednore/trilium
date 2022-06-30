resource "aws_lb" "app" {
  name                       = "lb-${local.slug}-app"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.app_lb_subnet_ids
  security_groups            = var.app_lb_sg_ids
  enable_deletion_protection = false # TODO: "production" == var.stage // If set as true, destroy process stucks at internet_gateway

  access_logs {
    bucket  = var.app_lb_log_bucket
    prefix  = local.slug
    enabled = true
  }

  tags = merge(local.default_tags, {
    Name = "lb-${local.slug}"
  })
}

resource "aws_lb_listener" "app_http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = merge(local.default_tags, {
    Name = "lbl-${local.slug}-app-http"
  })
}

resource "aws_lb_listener" "app_https" {
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_apex_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  tags = merge(local.default_tags, {
    Name = "lbl-${local.slug}-app-https"
  })
}

resource "aws_lb_listener_certificate" "cert_root" {
  listener_arn    = aws_lb_listener.app_https.arn
  certificate_arn = var.acm_apex_cert_arn
}

resource "aws_lb_listener_certificate" "cert_subdomain" {
  listener_arn    = aws_lb_listener.app_https.arn
  certificate_arn = aws_acm_certificate.subdomain.arn
}

resource "aws_lb_target_group" "app" {
  name     = "lbtg-${local.slug}"
  port     = var.app_lb_tg_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path              = "/"
    matcher           = "200"
    healthy_threshold = 2
  }

  tags = merge(local.default_tags, {
    Name = "lbtg-${local.slug}-app"
  })
}

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = var.app_instance_id
  port             = 80
}
