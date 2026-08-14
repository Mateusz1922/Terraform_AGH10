# main.tf

resource "aws_ecr_repository" "demo_repo" {
  name                 = "moj-testowy-rejestr-ecr"
  image_tag_mutability = "MUTABLE"
}