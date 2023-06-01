output "vpc_id" {
    value = aws_vpc.tf_vpc.id
}

output "vpc_cider" {
    value = aws_vpc.tf_vpc.cidr_block
}

output "public_subnets_id" {
    value = aws_subnet.public-subnet[*].id
}

output "private_subnets_id" {
    value = aws_subnet.private-subnet[*].id
}