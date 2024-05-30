resource "aws_vpc" "yahya" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "yahya"
  }
}