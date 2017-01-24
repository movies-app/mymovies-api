# ================================
# Subnets
# ================================

# Subnet terr-public-a
resource "aws_subnet" "terr-public-a" {
  vpc_id                    = "${aws_vpc.terr-vpc.id}"
  cidr_block                = "${var.subnet_public_a_cidr}"
  availability_zone         = "${var.subnet_public_a_region}"
  map_public_ip_on_launch   = true
  tags {
    Name = "terr-public-a"
  }
}

# Subnet terr-public-b
resource "aws_subnet" "terr-public-b" {
  vpc_id                    = "${aws_vpc.terr-vpc.id}"
  cidr_block                = "${var.subnet_public_b_cidr}"
  availability_zone         = "${var.subnet_public_b_region}"
  map_public_ip_on_launch   = true
  tags {
    Name = "terr-public-b"
  }
}

#Subnet terr-private-a
resource "aws_subnet" "terr-private-a" {
  vpc_id            = "${aws_vpc.terr-vpc.id}"
  cidr_block        = "${var.subnet_private_a_cidr}"
  availability_zone = "${var.subnet_private_a_region}"
  tags {
    Name = "terr-private-a"
  }
}

#Subnet terr-private-b
resource "aws_subnet" "terr-private-b" {
  vpc_id            = "${aws_vpc.terr-vpc.id}"
  cidr_block        = "${var.subnet_private_b_cidr}"
  availability_zone = "${var.subnet_private_b_region}"
  tags {
    Name = "terr-private-b"
  }
}