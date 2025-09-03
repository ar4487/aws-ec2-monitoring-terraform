terraform {
  cloud {
    organization = "Arpit-cg"

    workspaces {
      name = "AWS-EC2-Monitoring"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}
