resource "aws_instance" "agoge-tf-ec2" {
  ami                    = "ami-085f9c64a9b75eed5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.agoge-tf-sg.id]

  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        amazon-linux-extras install -y epel
        yum install -y aws-cli
        yum install -y inspector-agent
        systemctl enable awsagent.service
        systemctl start awsagent.service
        echo "Hello, World" > index.html
        nohup busybox httpd -f -p 8080 &
        EOF

  user_data_replace_on_change = true

  tags = {
    Name        = "agoge-tf-ec2-001"
    Environment = "testing"
  }
}


output "instance_ip_addr" {
  value = aws_instance.agoge-tf-ec2.public_ip
}