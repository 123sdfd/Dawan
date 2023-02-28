resource "aws_db_instance" "database" {
  allocated_storage    = 5
  db_name              = "lamp"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.db_username #sensitive
  password             = var.db_password #sensitive 
  parameter_group_name = aws_db_parameter_group.db_pg.name
  skip_final_snapshot    = true #Set to true to disable taking a final backup when you destroy the database later

  # storage_type         = "standard" #gp2
  db_subnet_group_name = aws_db_subnet_group.databasegroup.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  identifier             = "lampdb"
  #multi_az               = var.multi_az_db

  tags = {
    Name = "Bases de donnees"
  }
}


#This configuration enables connection logging for all instances using this parameter group.
resource "aws_db_parameter_group" "db_pg" {
  name   = "rds_pg"
  family = "mysql5.7"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}






