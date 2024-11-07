terraform {
  backend "s3" {
    profile        = "academy-box-1"
    encrypt        = true
    bucket         = "terraform-state-bucket-juan"
    region         = "us-east-1"
    dynamodb_table = "CLARIN-CLARINAPP-dev-DYNAMODB-STATE"
    key            = "iac/stack/poc/tg.tfstate"
  }
}
