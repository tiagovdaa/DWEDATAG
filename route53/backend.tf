terraform {
  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "global/route53/terraform.tfstate"
    region         = "your-aws-region"
    dynamodb_table = "your-dynamodb-table"
  }
}