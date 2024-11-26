resource "aws_rds_cluster_instance" "tf_aurora_cluster_instance" {
  cluster_identifier = aws_rds_cluster.tf_aurora_cluster.id

  count              = 1
  identifier         = "lanchonete-aurora-cluster-instance-${count.index + 1}"

  engine             = "aurora-mysql"
  engine_version     = "8.0.mysql_aurora.3.05.2"
  
  instance_class      = "db.serverless"
  publicly_accessible = false
  
  auto_minor_version_upgrade = true
  auto_major_version_upgrade = false
  apply_immediately   = true
}
