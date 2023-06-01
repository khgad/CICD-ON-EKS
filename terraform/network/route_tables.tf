resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "tf public route table"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "tf private route table"
  }
}

resource "aws_route_table_association" "public-rt-subnet" {
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-rt.id
  count = length(var.public_subnets_cidr)
}

resource "aws_route_table_association" "private-rt-subnet" {
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-rt.id
  count = length(var.private_subnets_cidr)
}