resource "aws_ecr_repository" "app" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE" # switch to IMMUTABLE once the pipeline tags by git SHA
  force_delete         = true      # lets terraform destroy work even when images exist

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep only the last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}

locals {
  registry = split("/", aws_ecr_repository.app.repository_url)[0]
  image    = "${aws_ecr_repository.app.repository_url}:${var.image_tag}"
}