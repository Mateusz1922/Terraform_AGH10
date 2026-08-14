# variables.tf
# This file defines input variables for your Terraform configuration, allowing you to parameterize your infrastructure. 
# Using variables instead of hardcoding values directly in resource declarations makes your configuration more flexible, 
# reusable, and secure for sensitive information.

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true # Marks this variable as sensitive, preventing it from appearing in logs and console output
}

variable "repository_name" {
  description = "Name of the GitHub repository to create"
  type        = string
  default     = "terraform-managed-repo"
}

variable "repository_description" {
  description = "Description of the GitHub repository"
  type        = string
  default     = "Repository managed by Terraform"
}

variable "publicly_visible" {
  description = "Visibility of the GitHub repository"
  type = boolean
  default = false
}


