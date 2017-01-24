resource "aws_db_instance" "movies-db-instance" {
  identifier             = "${var.rds_identifier}"
  allocated_storage      = "${var.rds_allocated_storage}"
  engine                 = "${var.rds_engine}"
  engine_version         = "${var.rds_engine_version}"
  instance_class         = "${var.rds_instance_class}"
  name                   = "${var.rds_db_name}"
  username               = "${var.rds_db_username}"
  password               = "${var.rds_db_password}"
  vpc_security_group_ids = ["${aws_security_group.terr-db-server.id}", "${aws_security_group.terr-ssh.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.terr-db-subnet-group.id}"
  port                   = "${var.rds_port}"
  tags {
    Name = "movies-db-instance"
  }
}

resource "aws_db_subnet_group" "terr-db-subnet-group" {
  name        = "terr-db-subnet-group"
  description = "DB group of subnets"
  subnet_ids  = ["${aws_subnet.terr-private-a.id}", "${aws_subnet.terr-private-b.id}"]
  tags {
    name = "terr-db-subnet-group"
  }
}