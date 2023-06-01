resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = var.AZs[count.index]
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "tf public subnet"
  }
  count = length(var.public_subnets_cidr)
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.AZs[count.index]
  tags = {
    "Name" = "tf private subnet"
  }
  count = length(var.private_subnets_cidr)
}

