resource "aws_db_instance" "wordpress" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  db_name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = var.db_subnet_group
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot  = true
} 