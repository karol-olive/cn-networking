output "vpc_id" {
  value = aws_ssm_parameter.vpc.id
}

output "public_subnets" {
  value = aws_ssm_parameter.subnet_public[*].id
}

output "private_subnets" {
  value = aws_ssm_parameter.subnet_private[*].id
}

output "database_subnets" {
  value = aws_ssm_parameter.subnet_databases[*].id
}
