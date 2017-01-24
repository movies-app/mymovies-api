provider "aws"{
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.aws_region}"
}

# The VPC where resources will live
resource "aws_vpc" "terr-vpc"  {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
  tags {
    Name = "terraform vpc"
  }
}

# ================================
# Internet gateway
# ================================
resource "aws_internet_gateway" "terr-ig" {
  vpc_id = "${aws_vpc.terr-vpc.id}"

  tags {
    Name = "terraform ig"
  }
}

# ================================
# Bastion Host
# ================================
resource "aws_instance" "terr-bastion" {
  ami                         = "ami-e13739f6" # Ubuntu 16.04 LTS
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.terr-ssh.id}"]
  subnet_id                   = "${aws_subnet.terr-public-a.id}"
  associate_public_ip_address = true
  source_dest_check           = true

  tags {
    Name = "terr-bastion"
  }
}
