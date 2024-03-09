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

# We can control the allowed outbound traffic by specifying a CIDR range
#
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
