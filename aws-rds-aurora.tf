resource "aws_rds_cluster" "tf_aurora_cluster" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = [var.aws_zone_1, var.aws_zone_2]
  database_name           = "lanchonete-db"
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.tf_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.tf_aurora_security_group.id]
  apply_immediately       = true
}

resource "aws_rds_cluster_instance" "tf_aurora_instance" {
  count               = 2
  identifier          = "aurora-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.tf_aurora_cluster.cluster_identifier
  instance_class      = "db.r6g.large"
  engine              = aws_rds_cluster.tf_aurora_cluster.engine
  engine_version      = aws_rds_cluster.tf_aurora_cluster.engine_version
  apply_immediately   = true
  tags = {
    Name = "aurora-instance-${count.index}"
  }
}
