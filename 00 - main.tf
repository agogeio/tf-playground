provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "agoge-tf-ec2" {
  ami                    = "ami-085f9c64a9b75eed5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.agoge-tf-sg.id]

  user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.html
        nohup busybox httpd -f -p 8080 &
        EOF

  user_data_replace_on_change = true

  tags = {
    Name        = "agoge-tf-ec2-001"
    Environment = "testing"
  }
}

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

output "instance_ip_addr" {
  value = aws_instance.agoge-tf-ec2.public_ip
}