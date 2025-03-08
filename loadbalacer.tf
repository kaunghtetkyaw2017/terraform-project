resource "aws_alb" "nginx-alb" {
  name = "nginx-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.alb-sg.id ]
  subnets = data.aws_subnets.public.ids
  
  enable_deletion_protection = false

    tags = {
        Name = "nginx-alb"
    }
}

resource "aws_lb_target_group" "nginx-tg" {
  name = "nginx-tg"
  port = local.http_port
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/"
    protocol = "HTTP"
    port = "traffic-port"
    timeout = 5
    interval = 30
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nginx-tg"
  }
  
}

resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_alb.nginx-alb.arn
  port = local.http_port
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nginx-tg.arn
  }
  
}

resource "aws_lb_target_group_attachment" "nginx-tg-attachment" {
  target_group_arn = aws_lb_target_group.nginx-tg.arn
  target_id = aws_instance.nginx-server.id
  port = local.http_port
  
}

