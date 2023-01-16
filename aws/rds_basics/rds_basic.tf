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

data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "rds_subnet" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "171.32.0.0/20"
  availability_zone = "eu-central-1b"
}

resource "random_string" "db-password" {
  length  = 32
  upper   = true
  numeric  = true
  special = false
}
resource "aws_security_group" "sg-rds" {
  vpc_id      = "${data.aws_vpc.default.id}"
  name        = "tf-sg"
  description = "Allow all inbound for Postgres"
ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "tf-example" {
  identifier             = "tf-example"
  db_name                = ""
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.7"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.sg-rds.id]
  username               = "postgres"
  password               = "random_string.db-password.result}"
}