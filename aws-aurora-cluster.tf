resource "aws_rds_cluster" "tf_aurora_cluster" {
  cluster_identifier      = "lanchonete-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.05.2"
  availability_zones      = [var.aws_zone_1, var.aws_zone_2]
  iam_roles               = [aws_iam_role.tf_aurora_role.arn]
  database_name           = "lanchonete"
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.tf_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.tf_aurora_security_group.id]
  deletion_protection     = false
  apply_immediately       = true
}