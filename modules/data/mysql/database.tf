resource "aws_db_instance" "database" {
  allocated_storage    = 5
  db_name              = "lamp"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "lamp"
  password             = "azerty"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot    = true

  storage_type         = "gp2"
  db_subnet_group_name = aws_db_subnet_group.databasegroup.name
  vpc_security_group_ids = [aws_security_group.dbsg.id]
  identifier             = "lampdb"
  multi_az               = var.multi_az_db

  tags {
    Name = "Bases de donnees"
  }
}


output "dburl" {
  value = aws_db_instance.database.address
}




