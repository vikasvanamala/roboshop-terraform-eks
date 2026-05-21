resource "aws_lb" "ingress_alb" {
  name               = "${local.common_name_suffix}-ingress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.ingress_alb_sg_id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false

  tags = merge (
    local.common_tags ,
        {
            Name = "${local.common_name_suffix}-ingress-alb"
        }

  )
}

resource "aws_lb_listener" "ingress_alb" {
  load_balancer_arn = aws_lb.ingress_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06" # Recommended default policy
  certificate_arn   = local.ingress_alb_certificate_arn

   default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> hi, iam from roboshop dev ingress alb </h1> "
      status_code  = "200"
    }
  }
}


resource "aws_route53_record" "ingress_alb" {
  zone_id = var.zone_id                 # The ID of your hosted zone
  name    = "*.${var.domain_name}"  # *.vicky08.fun
  type    = "A"                            # Alias records typically use type A or AAAA
  allow_overwrite = true

  alias {
    name                   = aws_lb.ingress_alb.dns_name    # Target DNS name (e.g., from an ALB)
    zone_id                = aws_lb.ingress_alb.zone_id    # Target hosted zone ID (specific to the resource)
    evaluate_target_health = true                   # Whether Route 53 checks target health
  }
}




