resource "aws_subnet" "public" {
  depends_on = [
    aws_vpc_ipv4_cidr_block_association.main
  ]

  count = length(var.public_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index].cidr

  tags = {
    Name = var.public_subnets[count.index].name
  }

}

resource "aws_subnet" "private" {
  depends_on = [
    aws_vpc_ipv4_cidr_block_association.main
  ]

  count = length(var.private_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index].cidr

  tags = {
    Name = var.private_subnets[count.index].name
  }
}

resource "aws_subnet" "database" {
  depends_on = [
    aws_vpc_ipv4_cidr_block_association.main
  ]

  count = length(var.database_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnets[count.index].cidr

  tags = {
    Name = var.database_subnets[count.index].name
  }
}
