resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.yahya.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "yahya"
  }
}

resource "aws_subnet" "eks-subnet1" {
  vpc_id     = aws_vpc.yahya.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks1"
  }
}
resource "aws_subnet" "eks-subnet2" {
  vpc_id     = aws_vpc.yahya.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = true

#auto assign public ip = true 

  tags = {
    Name = "eks2"
  }
}
