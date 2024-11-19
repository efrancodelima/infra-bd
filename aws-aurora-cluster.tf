module "rds_aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.10.0"
}

resource "aws_rds_cluster" "tf_aurora_cluster" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.10.0"
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.tf_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.tf_aurora_security_group.id]
}