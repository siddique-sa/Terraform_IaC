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


variable "s3_bucket_names" {
  type = list(string)
  default = ["", "", ""]
}


resource "aws_s3_bucket" "b" {
  count = length(var.s3_bucket_names)  
  bucket = var.s3_bucket_names[count.index]
  acl    = "private"

}

# resource "aws_s3_bucket_acl" "example_bucket_acl" {
#   count = length(var.s3_bucket_names)
#   bucket = var.s3_bucket_names[count.index].id
#   acl    = "private"
# }