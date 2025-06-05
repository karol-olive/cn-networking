project_name = "linuxtips-vpc"
vpc_cidr     = "10.0.0.0/16"
public_subnets = [
  {
    name              = "cloudnova-public-1a"
    cidr              = "10.0.48.0/24"
    availability_zone = "eu-west-1a"
  }
]

private_subnets = [
  {
    name              = "cloudnova-public-1a"
    cidr              = "10.0.0.0/20"
    availability_zone = "eu-west-1a"
  }
]

database_subnets = [
  {
    name              = "cloudnova-database-1a"
    cidr              = "10.0.51.0/24"
    availability_zone = "eu-west-1a"
  }
]

netacl_rules = [
  {
    network_acl_id = "subnet-01234567890abcdef" #just a random example for testing
    rule_number    = 200
    rule_action    = "allow"
    protocol       = "tcp"
    cidr_block     = "10.0.0.0/20"
    from_port      = 3306
    to_port        = 3306
  }
]
