resource "aws_security_group" "tf_aurora_security_group" {
  vpc_id = "vpc-0619b2c1d01be3a72"
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
