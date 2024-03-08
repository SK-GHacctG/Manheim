# output my application load balaner's put dns name
# for external used to access web site using this url 
#
data aws_lb my_alb_public_ip {
    name = aws_lb.my_web_alb.name
}

output my_alb_dns_name {
    value = aws_lb.my_web_alb.dns_name
}

# https://github.com/SK-GHacctG/Manheim.git