resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "tf internet gateway"
  }
}