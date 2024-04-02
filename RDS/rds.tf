
resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet"
  subnet_ids = [aws_subnet.hamid-priv-1.id,aws_subnet.hamid-priv-2.id]

  tags = {
    Name = "rds-subnet"
  }
}

resource "aws_db_parameter_group" "rds-parameter" {

  name   = "mysql-57-parameters"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

    lifecycle {
    create_before_destroy = true
  }

  


}

resource "aws_db_instance" "rds-resource" {
  identifier             = "rds-resource"
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "5.7"
  db_name                = "accounts"
  username               = var.db_user
  password               = var.db_pass
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.vpc_rds.id]
  parameter_group_name   = aws_db_parameter_group.rds-parameter.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = false
  storage_type           = "gp2"

}

output "rds_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds-resource.address
}

output "rds_endpoint" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds-resource.endpoint
}



