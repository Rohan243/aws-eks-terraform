provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = "~/.aws/credentials"
}
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}
