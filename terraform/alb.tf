resource "aws_lb" "app_alb" {
  name = "3-tier-stack-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb-sg.id]
  subnets = [aws_subnet.public-sub-1a.id, aws_subnet.public-sub-1b.id ]
  tags={
    Name = "3-tier-stack-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name = "3-tier-stack-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc-main.id

  health_check {
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
  }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app_tg.arn
    }
}