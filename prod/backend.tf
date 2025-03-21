terraform {
  backend "s3" {
    bucket         = "infra-state-820242919674"
    key            = "infra/prod/terraform.tfstate"
    region         = "us-east-1"
  }
}