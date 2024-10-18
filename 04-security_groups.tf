resource "aws_security_group" "agoge-tf-sg" {
  name = "agoge-tf-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "testing"
  }
}