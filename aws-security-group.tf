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