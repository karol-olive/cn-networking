## GENERAL ##
variable "project_name" {
  type        = string
  description = "The project name to compose the resources name"
}

## VPC ##
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "vpc_additional_cidrs" {
  type        = list(string)
  description = "CIDR's block addicional list"
  default     = []
}

## SUBNETS ##
variable "public_subnets" {
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
  description = "Public subnets list"
}

variable "private_subnets" {
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
  description = "Private subnets list"
}

variable "database_subnets" {
  type = list(object({
    name              = string
    cidr              = string
    availability_zone = string
  }))
  default     = []
  description = "Database subnets list. This kind of subnet is private and doens't have connection with internet and need to have network acl's"
}

variable "netacl_rules" {
  type = list(object({
    rule_number = number
    rule_action = string
    protocol    = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
  default     = []
  description = <<EOD
    List of Network ACL's for database subnet if applicable.
    Must contain:
      * rule_number: Number of the rule. Remember that rules are evaluated starting with the lowest numbered, more information here. https://docs.aws.amazon.com/vpc/latest/userguide/nacl-rules.html
      * rule_action: Allow or Deny.
      * protocol: The kind of protocol, to all use "-1" 
      * cidr_block: From where cidr the request will income.
      * from_port: original port
      * to_port: destination port
  EOD
}
