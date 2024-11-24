variable "aws_region" {
  description = "AWS region"
  type = string
}

variable "aws_zone_1" {
  description = "AWS AZ 1"
  type = string
}

variable "aws_zone_2" {
  description = "AWS AZ 2"
  type = string
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
}
