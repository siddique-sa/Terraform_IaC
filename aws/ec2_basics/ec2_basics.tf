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

resource "aws_instance" "s1" {
  count = 3
  ami           = "ami-0039da1f3917fa8e3"
  instance_type = "t2.micro"

  tags = {
    Name = "test-vm-${count.index}"
  }
}