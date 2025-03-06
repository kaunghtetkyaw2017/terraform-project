data "aws_vpc" "default" {
  default = true

}

resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "nginx-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh_port" {
  security_group_id = aws_security_group.nginx-sg.id
  cidr_ipv4         = local.anywhere
  from_port         = local.ssh_port
  to_port           = local.ssh_port
  ip_protocol       = local.tcp_protocol

}

resource "aws_vpc_security_group_ingress_rule" "allow-http-on-80" {
  security_group_id = aws_security_group.nginx-sg.id
  cidr_ipv4         = local.anywhere
  from_port         = local.http_port
  to_port           = local.http_port
  ip_protocol       = local.tcp_protocol

}

resource "aws_vpc_security_group_egress_rule" "name" {
  security_group_id = aws_security_group.nginx-sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_ports
}