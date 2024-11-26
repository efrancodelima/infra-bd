resource "aws_db_subnet_group" "tf_subnet_group" {
  name       = "lanchonete-aurora-subnet-group"
  subnet_ids = var.subnet_ids
}
