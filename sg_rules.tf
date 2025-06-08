resource "aws_security_group" "prod_sg" {
  vpc_id = aws_vpc.prod_vpc.id
  name = "prod_sg"
  description = "security groups for production server"

  tags = {
        Project = "ondemand_minecrat" 
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.prod_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22 # this block not needed if you dont need sssh access
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_minecraft_connections" {
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 25565 # minecraft server runs on this port
  to_port = 25565
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.prod_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}