resource "aws_db_subnet_group" "tf_subnet_group" {
  name       = "lanchonete-aurora-subnet-group"
  subnet_ids = [
    data.aws_subnet.tf_sub_priv_1.id,
    data.aws_subnet.tf_sub_priv_2.id
  ]
}
