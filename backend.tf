terraform {
  backend "s3" {
    bucket = "rohan-terraform-data"
    key    = "test"
    region = "eu-central-1"
  }
}
