provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "rohan-terraform-data"
    key    = "test"
    region = "eu-central-1"
  }
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}
