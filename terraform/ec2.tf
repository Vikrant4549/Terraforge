// Latest AMI template
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

// Create EC2
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.terraforge_sg.id ]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = true
  user_data_replace_on_change = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker aws-cli
              systemctl start docker
              systemctl enable docker

              # Login to ECR
              aws ecr get-login-password --region us-east-1 | \
              docker login --username AWS --password-stdin 444215322230.dkr.ecr.us-east-1.amazonaws.com

              # Pull image
              docker pull 444215322230.dkr.ecr.us-east-1.amazonaws.com/terraforge-app:v1

              # Run container
              docker run -d -p 80:3000 444215322230.dkr.ecr.us-east-1.amazonaws.com/terraforge-app:v1
              EOF

  tags = {
    Name = "terraforge-app-server"
  }
}
