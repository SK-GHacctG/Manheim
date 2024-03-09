# Defining Application Load Balancer
#
resource "aws_lb" "my_web_alb" {
  name               = "my-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_web_server_sg.id]
  subnets            = [var.var_subnet_id1,var.var_subnet_id2, var.var_subnet_id3]

  enable_deletion_protection = true

  # Assuming the bucket already exists, or the name is available to create
  #
  access_logs {
    bucket = "sklogbucket"
    prefix  = "skproject1log/my-web-alb"
    enabled = true
  }

  tags = {
    Environment = "staging"
  }
}


# Defining the target group and a health check on the application
#
resource "aws_lb_target_group" "my_target_group" {
  name                      = "my-ex-tg"
  port                      = 8081
  protocol                  = "HTTP"
  target_type               = "ip"
  vpc_id                    = var.var_vpc_id
  health_check {
      path                  = "/health"
      protocol              = "HTTP"
      matcher               = "200"
      port                  = "traffic-port"
      healthy_threshold     = 2
      unhealthy_threshold   = 2
      timeout               = 30          # can be adjusted up and down
      interval              = 60          # can be adjusted up and down
  }
}

# Defines an HTTP Listener for the ALB
#
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn         = aws_alb.my_web_alb.arn
  port                      = "80"
  protocol                  = "HTTP"

  default_action {
    type                    = "forward"
    target_group_arn        = aws_lb_target_group.my_target_group.arn
  }
}
