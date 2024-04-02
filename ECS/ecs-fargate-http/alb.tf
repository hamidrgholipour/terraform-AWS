resource "aws_alb" "application_load_balancer" {
  name               = "${var.namespace}-alb-1"
  internal           = false
  load_balancer_type = "application"

  subnets         = [aws_subnet.hamid_pub_1.id,aws_subnet.hamid_pub_2.id]
  security_groups = [aws_security_group.vpc_all.id]

  enable_deletion_protection = false

  tags = {
    Name = "${var.namespace}_alb-1" 
  }
}

resource "aws_alb_target_group" "tg-1" {
  name_prefix = "tg-1"
  port        = var.container_port
  protocol    = var.container_portocol
  vpc_id      = aws_vpc.hamid.id
  target_type = var.alb_target_type

  health_check {
    path                = var.health_check_path
    port                = var.container_port
    protocol            = var.container_portocol
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = var.healthcheck_matcher
  }
  load_balancing_algorithm_type = "round_robin"
  tags = {
    Name = "tg-1" 
  }
}

resource "aws_alb_listener" "application_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = var.alb_port
  protocol          = var.alb_protocol
  default_action {
    type             = "forward"
      forward {
        target_group {
          arn    = aws_alb_target_group.tg-1.arn
        }
      }    
  }
}

output "alb_dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}