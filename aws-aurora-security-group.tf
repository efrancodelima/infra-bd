resource "aws_security_group" "tf_aurora_security_group" {
  vpc_id = aws_vpc.tf_vpc.id
  name   = "lanchonete-aurora-security-group"
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
