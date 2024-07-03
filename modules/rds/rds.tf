resource "aws_db_instance" "db_instance" {

  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  iops                    = var.iops
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id
  license_model           = var.license_model  
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  port                    = var.port
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.db_subnet_group_name
  apply_immediately       = var.apply_immediately
  maintenance_window      = var.maintenance_window
  publicly_accessible     = false
  deletion_protection     = var.deletion_protection 
  skip_final_snapshot     = var.skip_final_snapshot
}

resource "aws_db_subnet_group" "this" {
  count = var.create_db_subnet_group ? 1 : 0

  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
}