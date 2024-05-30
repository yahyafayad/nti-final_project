resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.yahya.id 

  tags = {
    Name = "yahya"
  }
}