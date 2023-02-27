data "aws_availability_zones" "available" {
  state = "available"
}


#
resource "aws_vpc" "lamp_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "lamp"
  }
}

#
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lamp_vpc.id
  
  tags = {
    Name = "lamp"
  }
}


#
resource "aws_route_table" "webroute" {
  vpc_id = aws_vpc.lamp_vpc.id

  tags = {
    Name = "lamp"
  }
}


#
resource "aws_route_table" "dbroute" {
  vpc_id = aws_vpc.lamp_vpc.id

  tags = {
    Name = "lamp"
  }
}

#
resource "aws_subnet" "websubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = {
      Name = "web-subnet-${count.index}"
  }
}

resource "aws_subnet" "dbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index + 2)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = {
      Name = "db-subnet-${count.index}"
  }
}


resource "aws_db_subnet_group" "databasegroup" {
  name       = "lampdb"
  subnet_ids = aws_subnet.dbsubnets.*.id

  tags = {
      Name = "db-subnetgroup"
  }
}


#
resource "aws_route_table_association" "private_db_route_table_association" {
  count          = var.az_count #
  subnet_id      = element(aws_subnet.dbsubnets.*.id, count.index)
  route_table_id = aws_route_table.dbroute.id
}


resource "aws_route_table_association" "public_web_route_table_association" {
  count          = var.az_count #
  subnet_id      = element(aws_subnet.websubnets.*.id, count.index)
  route_table_id = aws_route_table.webroute.id
}


# nat gateway
#  resource "aws_eip" "gweip" {
#   count      = var.nat_count
#   vpc        = true
#   depends_on = [aws_internet_gateway.igw]

#   tags = {
#     Name = "eip-${count.index}"
#   }
# }


# resource "aws_nat_gateway" "ngw" {
#   count         = var.nat_count
#   subnet_id     = element(aws_subnet.lbsubnet.*.id, count.index)
#   allocation_id = element(aws_eip.gweip.*.id, count.index)

#   tags = {
#     Name = "ngw=${count.index}"
#   }
# } 



resource "aws_route" "internet_access_web" {
  route_table_id         = aws_route_table.webroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
