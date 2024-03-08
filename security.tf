resource "aws_security_group" "my_web_server_sg" {
  name = "my-web-server-sg"

# if we need to control from where the traffic is coming in, 
# we can replace the cidr block with an specific ip range
  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

# we can control the allowed outbound traffic be specifying a cidr range
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}