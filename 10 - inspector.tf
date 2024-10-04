# Enable AWS Inspector for your account (new Inspector version)
resource "aws_inspector2_organization_configuration" "example" {
  auto_enable {
    ec2   = true
    ecr   = true
    # lambda = true  # Enable for Lambda (optional)
  }
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
