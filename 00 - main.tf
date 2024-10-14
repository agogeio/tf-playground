variable "default_region" {
  description = "Default AWS Region"
  type        = string
}

provider "aws" {
  region = var.default_region
}

# Data sources to fetch AWS Account details
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
# To access a variable use the syntax below
# var.test_variable
# terraform apply -var "test_variable=10.0.0.0/24" as an example