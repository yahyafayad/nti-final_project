resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.yahya.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public route table"
  }
}

resource "aws_route_table_association" "public_routetable" {
  subnet_id      = aws_subnet.eks-subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_routetable2" {
  subnet_id      = aws_subnet.eks-subnet2.id 
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_routetable3" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public_route_table.id
}
