# Generujemy losowy ciąg znaków, bo nazwa bucketa w S3 musi być unikalna na całym świecie
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# 1. Tworzymy bucket S3 na plik stanu
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "moj-tf-state-${random_string.suffix.result}"
  force_destroy = true # Pozwala na usunięcie bucketa przy terraform destroy
}

# 2. Przykładowy zasób z polecenia (rejestr ECR)
resource "aws_ecr_repository" "demo_repo" {
  name                 = "moj-testowy-rejestr-ecr"
  image_tag_mutability = "MUTABLE"
}

# 3. Wyświetlamy dokładnie wygenerowaną nazwę bucketa
output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

provider "github" {
  token = var.github_token
}