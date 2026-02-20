output "wordpress_ip" {
  value = aws_instance.wordpress_server.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.mi_db.endpoint
}