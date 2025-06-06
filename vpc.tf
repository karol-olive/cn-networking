resource "aws_vpc" "main" {
  #checkov:skip=CKV2_AWS_11: The flow logging is not necessary on this scenario.
  #checkov:skip=CKV2_AWS_12: The security group doesn't make part of this module.
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.project_name
  }

}

resource "aws_vpc_ipv4_cidr_block_association" "main" {
  count = length(var.vpc_additional_cidrs)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_additional_cidrs[count.index]
}

