resource "aws_rds_cluster" "tf_aurora_cluster" {
  cluster_identifier            = "lanchonete-aurora-cluster"
  availability_zones            = [var.aws_zone_1, var.aws_zone_2]
  
  engine                        = "aurora-mysql"
  engine_version                = "8.0.mysql_aurora.3.08.0"
  engine_mode                   = "provisioned"
  serverlessv2_scaling_configuration {
    min_capacity = 0
    max_capacity = 4
  }

  db_subnet_group_name          = aws_db_subnet_group.tf_subnet_group.name
  vpc_security_group_ids        = [ aws_security_group.tf_security_group.id ]
  iam_roles                     = [aws_iam_role.tf_role.arn]
  
  database_name                 = "lanchonete"
  port                          = 3306
  master_username               = var.db_username
  master_password               = var.db_password

  backup_retention_period       = 1
  preferred_backup_window       = "05:48-06:18"
  preferred_maintenance_window  = "sat:03:02-sat:03:32"
  storage_encrypted             = false
  copy_tags_to_snapshot         = false
  deletion_protection           = false
  skip_final_snapshot           = true
  apply_immediately             = true

  lifecycle {
    ignore_changes = [ availability_zones ]
  }
}
