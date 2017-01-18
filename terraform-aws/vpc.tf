provider "aws"{
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.aws_region}"
}

# The VPC where resources will live
resource "aws_vpc" "terr-vpc"  {
  cidr_block = "10.2.0.0/16"

  tags {
    Name = "terraform vpc"
  }
}

# Internet gateway
resource "aws_internet_gateway" "terr-ig" {
  vpc_id = "${aws_vpc.terr-vpc.id}"

  tags {
    Name = "terraform ig"
  }
}

# Subnet terr-public-a
resource "aws_subnet" "terr-public-a" {
  vpc_id                    = "${aws_vpc.terr-vpc.id}"
  cidr_block                = "10.2.0.0/24"
  map_public_ip_on_launch   = true
  availability_zone         = "us-east-1a"
  tags {
    Name = "terr-public-a"
  }
}

# Subnet terr-public-b
resource "aws_subnet" "terr-public-b" {
  vpc_id                    = "${aws_vpc.terr-vpc.id}"
  cidr_block                = "10.2.1.0/24"
  map_public_ip_on_launch   = true
  availability_zone         = "us-east-1b"
  tags {
    Name = "terr-public-b"
  }
}

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

resource "aws_network_acl" "terr-web-traffic" {
  vpc_id = "${aws_vpc.terr-vpc.id}"
  subnet_ids = [
    "${aws_subnet.terr-public-a.id}", "${aws_subnet.terr-public-b.id}"
  ]
  tags = {
    Name = "terr-web-traffic"
  }
}

resource "aws_network_acl_rule" "terr-web-traffic-http-ingress" {
  network_acl_id = "${aws_network_acl.terr-web-traffic.id}"
  rule_number = 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 80
  to_port = 80
}

resource "aws_network_acl_rule" "terr-web-traffic-https-ingress" {
  network_acl_id = "${aws_network_acl.terr-web-traffic.id}"
  rule_number = 101
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 443
  to_port = 443
}

resource "aws_network_acl_rule" "terr-web-traffic-egress" {
  network_acl_id = "${aws_network_acl.terr-web-traffic.id}"
  rule_number = 100
  egress = true
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}

# Security Groups
resource "aws_security_group" "terr-web-server" {
  name = "terr-web-server"
  description = "Web application security"
  vpc_id = "${aws_vpc.terr-vpc.id}"
  tags = {
    Name = "terr-web-server"
  }
}

resource "aws_security_group_rule" "terr-web-server-http-in" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-https-in" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}

resource "aws_security_group_rule" "terr-web-server-out" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.terr-web-server.id}"
}


# Elastic Load Balancer
resource "aws_elb" "terr-elb" {
  name = "terr-elb"
//  availability_zones = ["us-east-1a", "us-east-1b"]
  security_groups = ["${aws_security_group.terr-web-server.id}"]
  subnets = ["${aws_subnet.terr-public-a.id}", "${aws_subnet.terr-public-b.id}"]

//  access_logs {
//    bucket = "foo"
//    bucket_prefix = "bar"
//    interval = 60
//  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

//  listener {
//    instance_port = 8000
//    instance_protocol = "http"
//    lb_port = 443
//    lb_protocol = "https"
//    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
//  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  instances = ["${aws_instance.terr-web-instance.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "terr-elb"
  }
}

resource "aws_instance" "terr-web-instance" {
  instance_type = "t2.micro"

  ami = "ami-1b141471"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "mfadmin-aws-auth"

  availability_zone = ""
  subnet_id = "${aws_subnet.terr-public-a.id}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [
    "${aws_security_group.terr-web-server.id}"]

  #Instance tags
  tags {
    Name = "terr-instance-example"
  }

}

# Elastic Beanstalk
//resource "aws_elastic_beanstalk_application" "mymovies-api" {
//  name = "mymovies-api"
//  description = "MyMoviesApi Application"
//}
//
//resource "aws_elastic_beanstalk_environment" "mymovies-api-test" {
//  name = "mymovies-api-test"
//  application = "${aws_elastic_beanstalk_application.mymovies-api.name}"
//  tier = "WebServer"
//  solution_stack_name = "64bit Amazon Linux 2016.09 v2.5.0 running Tomcat 8 Java 8"
//  load_balancers = ["${aws_elb.terr-elb.id}"]
//  setting {
//    namespace = "aws:ec2:vpc"
//    name      = "VPCId"
//    value     = "${aws_vpc.terr-vpc.id}"
//  }
//  setting {
//    namespace = "aws:ec2:vpc"
//    name      = "Subnets"
//    value     = "${aws_subnet.terr-public-a.id}, ${aws_subnet.terr-public-b.id}"
//  }
//  setting {
//    namespace = "aws:ec2:vpc"
//    name      = "AssociatePublicIpAddress"
//    value     = "true"
//  }
//  setting {
//    namespace = "aws:autoscaling:launchconfiguration"
//    name      = "InstanceType"
//    value     = "t2.micro"
//  }
//  setting {
//    namespace = "aws:autoscaling:asg"
//    name      = "MinSize"
//    value     = "1"
//  }
//  setting {
//    namespace = "aws:autoscaling:asg"
//    name      = "MaxSize"
//    value     = "2"
//  }
//  setting {
//    namespace = "aws:autoscaling:launchconfiguration"
//    name      = "SecurityGroups"
//    value     = "${aws_security_group.terr-web-server.id}"
//  }
//  tags {
//    Name = "mymovies-api-test"
//    Team = "The Movie team"
//  }
//}

