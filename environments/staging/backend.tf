terraform {
  backend "s3" {
    bucket         = "terraform-000-state"
    key            = "aws/staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
