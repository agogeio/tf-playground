resource "aws_inspector2_enabler" "agoge-tf-inspector" {
  account_ids    = ["442426854829"]
  resource_types = ["EC2"]
}