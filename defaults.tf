
resource "aws_default_route_table" "defaultroute" {
  default_route_table_id = aws_vpc.lamp_vpc.default_route_table_id

  tags = {
    Name = "defaultroute"
  }
}



resource "aws_default_network_acl" "defaultnacl" {
  default_network_acl_id = aws_vpc.lamp_vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = {
    Name = "defaultroute"
  }
}


resource "aws_default_security_group" "defaultsg" {
  vpc_id = aws_vpc.lamp_vpc.id

  tags = {
    Name = "defaultsg"
  }

}