# Configurar o grupo de sub-rede do Aurora
resource "aws_db_subnet_group" "tf_subnet_group" {
  name       = "lanchonete-aurora-subnet-group"
  subnet_ids = [
    subnet-070df2dd859ac9173,
    subnet-013f3649edb4c051b,
    subnet-077d0b4dda8063a54,
    subnet-0a2e35524708401dd
  ]
}


