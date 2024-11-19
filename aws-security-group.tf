resource "aws_security_group" "tf_aurora_security_group" {
  vpc_id = aws_vpc.lanchonete_vpc.id
  name   = "aurora-security-group"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
