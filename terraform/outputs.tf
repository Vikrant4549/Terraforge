output "app_url" {
  value = "http://${aws_instance.app_server.public_ip}"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "instance_id" {
  value = aws_instance.app_server.id
}