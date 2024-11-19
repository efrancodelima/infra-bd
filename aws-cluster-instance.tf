resource "aws_rds_cluster_instance" "tf_aurora_instance" {
  cluster_identifier  = "aurora-cluster"
  instance_class      = "db.r6g.large"
  engine              = aws_rds_cluster.tf_aurora_cluster.engine
  apply_immediately   = true
  tags = {
    Name = "aurora-instance"
  }
}