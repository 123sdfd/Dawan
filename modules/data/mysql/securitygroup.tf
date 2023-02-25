resource "aws_security_group" "db_sg" {
  name        = "dbsg-${terraform.workspace}"
  description = "controls access to the LB"
  vpc_id      = aws_vpc.lamp_vpc.id
  tags = merge(
    {
      "Name" : "dbsg-${terraform.workspace}"
    }, var.default_tags
  )
}


resource "aws_security_group_rule" "web_to_db" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
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
