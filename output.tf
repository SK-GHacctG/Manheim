# Output - application load balancer's DNS name
# for external users to access the website using this URL 
#
data aws_lb my_alb_public_ip {
    name = aws_lb.my_web_alb.name
}

output my_alb_dns_name {
    value = aws_lb.my_web_alb.dns_name
}
