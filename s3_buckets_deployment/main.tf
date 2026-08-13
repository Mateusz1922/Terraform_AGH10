# main.tf

terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Domyślny provider dla pierwszego regionu (us-east-1)
provider "aws" {
  region = var.regions[0]
}

# define rest of providers, each for the regions you specified, do not forget about the alias option that must be a string
#...
# Provider z aliasem dla drugiego regionu (us-west-2)
provider "aws" {
  alias  = "us_west_2"
  region = var.regions[1]
}