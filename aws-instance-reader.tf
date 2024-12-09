resource "aws_rds_cluster_instance" "tf_instance_reader" {
  cluster_identifier = aws_rds_cluster.tf_aurora_cluster.id

  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.tf_aurora_cluster.engine
  engine_version      = aws_rds_cluster.tf_aurora_cluster.engine_version

  apply_immediately   = true
  auto_minor_version_upgrade = true

  depends_on = [
    aws_rds_cluster.tf_aurora_cluster
  ]

  lifecycle {
    ignore_changes = [
      apply_immediately,
      force_destroy
    ]
  }
}