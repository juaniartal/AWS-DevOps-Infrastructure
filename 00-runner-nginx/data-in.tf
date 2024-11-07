data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    profile        = "academy-box-1" 
    encrypt        = true
    bucket         = "terraform-state-bucket-juan"
    region         = "us-east-1"
    dynamodb_table = "CLARIN-CLARINAPP-dev-DYNAMODB-STATE"
    key            = "iac/stack/poc/vpc.tfstate"
  }
}