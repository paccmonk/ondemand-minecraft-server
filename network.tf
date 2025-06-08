resource "aws_vpc" "prod_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "prod_vpc"
        Project = "ondemand_minecrat" 
    }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.prod_vpc.id
  cidr_block = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
        Name = "Public subnet ${count.index + 1}"
        Project = "ondemand_minecrat"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
        Project = "ondemand_minecrat"
    }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
        Project = "ondemand_minecrat" 
    }
}

resource "aws_route_table_association" "public_subnets_asso" {
  route_table_id = aws_route_table.second_rt.id
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
}