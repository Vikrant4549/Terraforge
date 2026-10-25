variable "region" {
  type    = string
  default = "us-east-1"
}

variable "image_tag" {
  type    = string
  default = "v1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ecr_repo_name" {
  type    = string
  default = "terraforge-app"
}