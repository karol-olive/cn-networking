run "validate_min_network_requirements" {

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = length(aws_subnet.public) >= 1
    error_message = "At least one public subnet is required"
  }

  assert {
    condition     = length(aws_subnet.private) >= 1
    error_message = "At least one private subnet is required"
  }

  assert {
    condition     = !(length(aws_subnet.database) == 0 && length(aws_network_acl_rule.allow_rules) >= 0)
    error_message = "The subnet database is mandatory when is creating network acls rules"
  }

  assert {
    condition     = !(length(aws_subnet.database) > 0 && length(aws_network_acl_rule.allow_rules) == 0)
    error_message = "The network acl's rules is mandatory when is creating databases subnets"
  }
}
