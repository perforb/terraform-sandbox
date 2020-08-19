resource "aws_ecr_repository" "app_api_registry" {
  name = "ecr-app-api"
}

resource "aws_ecr_repository" "web_registry" {
  name = "ecr-web"
}

resource "aws_ecr_lifecycle_policy" "api" {
  repository = aws_ecr_repository.api_registry.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 30 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["release"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}