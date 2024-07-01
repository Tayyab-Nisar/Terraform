# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name: "my_vpc"
  }
}
resource "aws_subnet" "my-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    name: "my_subnet"
  }
  availability_zone = "eu-north-1a"
}
resource "aws_internet_gateway" "my-gate-way" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    name: "my_gate_way"
  }
}
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gate-way.id
  }
  tags = {
    name: "my_route-table"
  }
}

resource "aws_route_table_association" "my-subnet-associ" {
  route_table_id = aws_route_table.my-route-table.id
  subnet_id = aws_subnet.my-subnet.id
}
