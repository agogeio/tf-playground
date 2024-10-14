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
