resource "aws_inspector2_enabler" "example" {
  account_ids    = ["442426854829"]
  resource_types = ["EC2"]
}