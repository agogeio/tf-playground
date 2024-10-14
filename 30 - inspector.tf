variable "account_id" {
  description = "account id"
  type        = string
}

resource "aws_inspector2_enabler" "agoge-tf-inspector" {
  account_ids    = [var.account_id]
  resource_types = ["EC2"]
}