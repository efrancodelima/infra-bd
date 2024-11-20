resource "aws_rds_cluster_instance" "tf_aurora_instance" {
  count               = 1
  identifier          = "aurora-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.tf_aurora_cluster.cluster_identifier
  instance_class      = "db.t3.medium"
  engine              = aws_rds_cluster.tf_aurora_cluster.engine
  engine_version      = aws_rds_cluster.tf_aurora_cluster.engine_version
  apply_immediately   = true
  tags = {
    Name = "lanchonete-aurora-instance-${count.index}"
  }
}
