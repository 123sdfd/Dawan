resource "aws_security_group" "db_sg" {
  name        = "dbsg"
  description = "controls access to the LB"
  vpc_id      = aws_vpc.lamp_vpc.id
  
  tags = {
      "Name" = "dbsg"
    }
}


resource "aws_security_group_rule" "web_to_db" {
  type                     = "ingress"
  from_port                = 5433
  to_port                  = 5433
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.db_sg.id
}


resource "aws_security_group_rule" "db_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_sg.id
}
