# ================================
# Public Traffic Route Table
# ================================

resource "aws_route_table" "terr-public-traffic" {

  vpc_id = "${aws_vpc.terr-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terr-ig.id}"
  }
  tags {
    Name = "terr-public-traffic"
  }
}

resource "aws_route_table_association" "terr-rta-public-a" {
  subnet_id = "${aws_subnet.terr-public-a.id}"
  route_table_id = "${aws_route_table.terr-public-traffic.id}"
}

resource "aws_route_table_association" "terr-rta-public-b" {
  subnet_id = "${aws_subnet.terr-public-b.id}"
  route_table_id = "${aws_route_table.terr-public-traffic.id}"
}

# ================================
# Private Traffic Route Table
# ================================
resource "aws_route_table" "terr-private-traffic" {
  vpc_id = "${aws_vpc.terr-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.terr-nat.id}"
  }

  tags {
    Name = "terr-private-traffic"
  }
}

resource "aws_route_table_association" "terr-rta-private-a" {
  subnet_id = "${aws_subnet.terr-private-a.id}"
  route_table_id = "${aws_route_table.terr-private-traffic.id}"
}

resource "aws_route_table_association" "terr-rta-private-b" {
  subnet_id = "${aws_subnet.terr-private-b.id}"
  route_table_id = "${aws_route_table.terr-private-traffic.id}"
}