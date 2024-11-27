# Região e AZ
variable "aws_region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "aws_zone_1" {
  description = "AWS AZ 1"
  type = string
  default = "us-east-1a"
}

variable "aws_zone_2" {
  description = "AWS AZ 2"
  type = string
  default = "us-east-1b"
}

# Banco de dados Aurora
variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
}

# VPC e subnets
variable "vpc_id" {
  description = "O id da VPC"
  type = string
  default = "vpc-0011200375d4dffa2"
}

variable "subnet_ids" {
  description = "A lista com os ids das subnets privadas"
  type = list(string)
  default = [
    "subnet-074acabffa0581567",   # private 1
    "subnet-0bba13eebef880c40"    # private 2
  ]
}
