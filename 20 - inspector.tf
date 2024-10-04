resource "aws_inspector2_enabler" "example" {
  account_ids    = ["442426854829"]
  resource_types = ["EC2"]
}

# Set up AWS Inspector filters (optional, but used to define the findings you want)
# resource "aws_inspector2_filter" "example_filter" {
#   name = "example-inspector-filter"
  
#   filter {
#     finding_criteria {
#       criterion {
#         # Filter based on vulnerability type, severity, etc.
#         severity = {
#           comparison = "EQUALS"
#           value      = "CRITICAL"
#         }
#       }
#     }

#     action = "SUPPRESS"  # You can either SUPPRESS or NOTIFY based on the criteria
#   }
# }
