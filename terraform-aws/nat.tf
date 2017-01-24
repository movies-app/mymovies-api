# ================================
# NAT
# ================================
resource "aws_instance" "terr-nat" {
  ami                         = "${var.nat_ami}" # this is a special ami preconfigured to do NAT
  availability_zone           = "${var.nat_region}"
  instance_type               = "${var.nat_instance_type}"
  key_name                    = "${var.aws_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.terr-nat-sg.id}"]
  subnet_id                   = "${aws_subnet.terr-public-a.id}"
  associate_public_ip_address = true
  source_dest_check = false

  tags {
    Name = "terr-vpc-nat"
  }
}

resource "aws_security_group" "terr-nat-sg" {
  name = "vpc_nat"
  description = "NAT SG: Allow traffic to pass from the private subnet to the internet"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.2.2.0/28", "10.2.2.32/28"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.2.2.0/28", "10.2.2.32/28"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.2.0.0/16"]
  }

  vpc_id = "${aws_vpc.terr-vpc.id}"

  tags {
    Name = "terr-nat-sg"
  }
}