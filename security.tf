resource "aws_security_group" "my_web_server_sg" {
  name = "my-web-server-sg"

# If we need to control where the traffic is coming in, 
# We can replace the cidr block with a specific IP range
#
  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

# We can control the allowed outbound traffic by specifying a CIDR range
#
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

# It also makes sense to create a separate security group for ECS Service
# Allowing any traffic from the Load Balancer
# 
resource "aws_security_group" "my_ecs_sg" {
    vpc_id                      = var.var_vpc_id
    name                        = "myWebAppECSsg"
    description                 = "Security group for ecs service"
    revoke_rules_on_delete      = true
}

# ECS app Security Group Rules - INBOUND
# 
resource "aws_security_group_rule" "ecs_alb_ingress" {
    type                        = "ingress"
    from_port                   = 0
    to_port                     = 0
    protocol                    = "-1"
    description                 = "Allow inbound traffic from ALB"
    security_group_id           = aws_security_group.my_ecs_sg.id
    source_security_group_id    = aws_security_group.my_web_server_sg.id
}

# ECS app Security Group Rules - OUTBOUND
# 
resource "aws_security_group_rule" "ecs_all_egress" {
    type                        = "egress"
    from_port                   = 0
    to_port                     = 0
    protocol                    = "-1"
    description                 = "Allow outbound traffic from ECS"
    security_group_id           = aws_security_group.my_ecs_sg.id
    cidr_blocks                 = ["0.0.0.0/0"] 
}
