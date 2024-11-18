# Configurar o grupo de sub-rede do Aurora
resource "aws_db_subnet_group" "aurora" {
  name       = "aurora"
  subnet_ids = [aws_subnet.public.id, aws_subnet.private.id]
}

