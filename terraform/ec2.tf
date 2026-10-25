// Latest AMI template
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

// Create EC2
resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.terraforge_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = true
  user_data_replace_on_change = true

  metadata_options {
    http_tokens   = "required" # enforce IMDSv2
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted = true
  }

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y docker aws-cli
              systemctl enable --now docker

              # Login to ECR
              aws ecr get-login-password --region ${var.region} | \
              docker login --username AWS --password-stdin ${local.registry}

              # Pull image
              docker pull ${local.image}

              # Run container
              docker run -d --restart unless-stopped -p 80:3000 ${local.image}
              EOF

  tags = {
    Name = "terraforge-app-server"
  }
}
