resource "aws_network_acl" "database" {
  #checkov:skip=CKV2_AWS_1:The ACL will just be apply when the subnet database was created. Not mandatory
  count = length(var.database_subnets)

  vpc_id = aws_vpc.main.id

  egress {
    rule_no    = 200
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = format("netacl-%s-subnet-databases", var.project_name)
  }
}

resource "aws_network_acl_rule" "deny" {
  count = length(var.database_subnets)

  network_acl_id = aws_network_acl.database[count.index].id
  rule_number    = "300"
  rule_action    = "deny"

  protocol   = "-1"
  cidr_block = "0.0.0.0/0"
  from_port  = 0
  to_port    = 0
}

resource "aws_network_acl_rule" "allow_rules" {
  depends_on = [
    aws_subnet.database
  ]

  count = length(var.netacl_rules)

  network_acl_id = aws_network_acl.database[count.index].id
  rule_number    = var.netacl_rules[count.index].rule_number
  rule_action    = var.netacl_rules[count.index].rule_action

  protocol   = var.netacl_rules[count.index].protocol
  cidr_block = var.netacl_rules[count.index].cidr_block
  from_port  = var.netacl_rules[count.index].from_port
  to_port    = var.netacl_rules[count.index].to_port
}

resource "aws_network_acl_association" "database" {
  count = length(var.database_subnets)

  network_acl_id = aws_network_acl.database[count.index].id
  subnet_id      = aws_subnet.database[count.index].id
}
