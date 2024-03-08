resource "aws_lb" "my_web_alb" {
  name               = "my-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_web_server_sg.id]
  subnets            = [var.var_subnet_id1,var.var_subnet_id2]

  enable_deletion_protection = true

  access_logs {
    bucket = "sktfstatebucket"
    prefix  = "skproject1log/my-web-alb"
    enabled = true
  }

  tags = {
    Environment = "staging"
  }
}