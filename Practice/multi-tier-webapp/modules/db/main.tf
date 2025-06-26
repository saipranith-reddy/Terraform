resource "aws_db_subnet_group" "db" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_db_instance" "db" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  db_subnet_group_name = aws_db_subnet_group.db.name
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin123"
  publicly_accessible  = false
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}