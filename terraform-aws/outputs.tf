output "vpc-id" {
  value = "${aws_vpc.terr-vpc.id}"
}

output "subnet-public-a" {
  value = "${aws_subnet.terr-public-a.id}"
}

output "subnet-public-b" {
  value = "${aws_subnet.terr-public-b.id}"
}

output "terr-elb-name-id" {
  value = "${aws_elb.terr-elb.id}"
}

output "terr-elb-name" {
  value = "${aws_elb.terr-elb.name}"
}

output "terr-elb-sg" {
  value = "${aws_elb.terr-elb.security_groups}"
}

output "terr-web-server-sq" {
  value = "${aws_security_group.terr-web-server.id}"
}