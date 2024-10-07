variable default_region {
  description = "Default AWS Region"
  type  = string
}

provider "aws" {
  region = var.default_region
}

variable "test_variable" {
  description = "Test variable for documentation"
  default     = "Some String"
  type        = string
  # type      = any
}

# To access a variable use the syntax below
# var.test_variable
# terraform apply -var "test_variable=10.0.0.0/24" as an example