# Configurar o grupo de sub-rede do Aurora
resource "aws_db_subnet_group" "tf_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = [
    aws_subnet.tf_public_subnet[0].id,
    aws_subnet.tf_public_subnet[1].id,
    aws_subnet.tf_private_subnet[0].id,
    aws_subnet.tf_private_subnet[1].id
  ]
}
