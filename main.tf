# Adicionar o módulo Terraform para RDS Aurora
module "rds_aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.10.0"
}

# Configurar o cluster Aurora
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "lanchonete-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.10.0"
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.aurora.name
  vpc_security_group_ids  = [aws_security_group.aurora.id]
  tags = {
    Name = "lanchonete-aurora-cluster"
  }
}

# Configurar o grupo de sub-rede do Aurora
resource "aws_db_subnet_group" "aurora" {
  name       = "aurora"
  subnet_ids = [aws_subnet.public.id, aws_subnet.private.id]
}

# Configurar o grupo de segurança do Aurora
resource "aws_security_group" "aurora" {
  vpc_id = aws_vpc.main.id
  name   = "aurora"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Configurar a instância do Aurora
resource "aws_rds_cluster_instance" "aurora" {
  cluster_identifier  = aws_rds_cluster.aurora.id
  instance_class      = "db.r6g.large"
  engine              = aws_rds_cluster.aurora.engine
  apply_immediately   = true
  tags = {
    Name = "aurora-instance"
  }
}

# Definir variáveis
variable "db_username" {
  description = "Nome de usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
}
