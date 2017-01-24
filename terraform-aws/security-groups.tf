resource "aws_security_group" "terr-ssh" {
  name        = "terr-ssh"
  description = "SSH access"
  vpc_id = "${aws_vpc.terr-vpc.id}"
  tags {
    Name = "terr-ssh"
  }
}

resource "aws_security_group" "terr-web-server" {
  name = "terr-web-server"
  description = "Web application security"
  vpc_id = "${aws_vpc.terr-vpc.id}"
  tags = {
    Name = "terr-web-server"
  }
}

resource "aws_security_group" "terr-db-server" {
  name = "terr-db-server"
  description = "RDS DB security"
  vpc_id = "${aws_vpc.terr-vpc.id}"
  tags = {
    Name = "terr-db-server"
  }
}

# ===============================
# terr-ssh rules
# ===============================

resource "aws_security_group_rule" "terr-ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-ssh.id}"
}

resource "aws_security_group_rule" "terr-ssh-out" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-ssh.id}"
}

# ===============================
# terr-web-server rules
# ===============================

resource "aws_security_group_rule" "terr-web-server-http-in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-https-in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-ssh-in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.terr-ssh.id}"
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-mysql-out" {
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.terr-db-server.id}"
  security_group_id        = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-http-out" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-https-out" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

# ===============================
# terr-db-server rules
# ===============================
resource "aws_security_group_rule" "terr-db-server-mysql-in" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.terr-web-server.id}"
  security_group_id        = "${aws_security_group.terr-db-server.id}"
}

resource "aws_security_group_rule" "terr-db-server-ssh-in" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.terr-ssh.id}"
  security_group_id        = "${aws_security_group.terr-db-server.id}"
}

resource "aws_security_group_rule" "terr-db-server-http-out" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-db-server.id}"
}

resource "aws_security_group_rule" "terr-db-server-https-out" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-db-server.id}"
}