# providers.tf

terraform {
  # Note here that required_version is declared differently.
  # It means that the required version of Terraform is >=1.0 and <2.0.
  required_version = "~> 1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# default provider configuration
provider "aws" {
  region = "eu-central-1"
}

# provider alias with another region
provider "aws" {
  alias  = "eu_west_3"
  region = "eu-west-3"
}