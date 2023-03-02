output "alburl" {
  value = aws_lb.lampalb.dns_name
}

output "dburl" {
  value = aws_db_instance.database.endpoint
}