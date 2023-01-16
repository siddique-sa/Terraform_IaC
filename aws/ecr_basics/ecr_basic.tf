terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "eu-central-1"
  access_key = "*****"
  secret_key = "*****"
}

#the below is private repo
resource "aws_ecr_repository" "ecr" {
  count = 3
  name                 = "serverless-ui-${count.index}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

#the below is public repo
resource "aws_ecrpublic_repository" "ecr" {
  repository_name      = "serverless-ui"
}