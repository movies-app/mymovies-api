output "vpc-id" {
  value = "${aws_vpc.terr-vpc.id}"
}

output "public-subnets" {
  value = "${aws_subnet.terr-public-a.id},${aws_subnet.terr-public-b.id}"
}

output "private-subnets" {
  value = "${aws_subnet.terr-private-a.id},${aws_subnet.terr-private-b.id}"
}

output "terr-web-server-sg" {
  value = "${aws_security_group.terr-web-server.id}"
}

output "terr-ssh-sg" {
  value = "${aws_security_group.terr-ssh.id}"
}

output "terr-db-server-sg" {
  value = "${aws_security_group.terr-db-server.id}"
}

output "movies-db-host" {
  value = "${aws_db_instance.movies-db-instance.endpoint}"
}

output "terr-elb-id" {
  value = "${aws_elb.terr-elb.id}"
}

output "terr-elb-name" {
  value = "${aws_elb.terr-elb.name}"
}

output "terr-elb-sg" {
  value = "${aws_elb.terr-elb.security_groups}"
}

output "nat-id" {
  value = "${aws_instance.terr-nat.id}"
}

output "bastion-id" {
  value = "${aws_instance.terr-bastion.id}"
}

output "bastion-public-dns" {
  value = "${aws_instance.terr-bastion.public_dns}"
}

output "bastion-public-ip" {
  value = "${aws_instance.terr-bastion.public_ip}"
}

output "bastion-private-ip" {
  value = "${aws_instance.terr-bastion.private_ip}"
}