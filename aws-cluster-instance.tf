resource "aws_rds_cluster_instance" "aurora" {
  cluster_identifier  = aws_rds_cluster.aurora.id
  instance_class      = "db.r6g.large"
  engine              = aws_rds_cluster.aurora.engine
  apply_immediately   = true
  tags = {
    Name = "aurora-instance"
  }
}