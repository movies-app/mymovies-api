variable "aws_access_key" { }
variable "aws_secret_key" { }
variable "aws_key_name" { }

variable "aws_region" {
  description = "The AWS region to build this in"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
}

variable "subnet_public_a_cidr" {
  description = "Subnet Public A CIDR"
}

variable "subnet_public_a_region" {
  description = "Subnet Public A Region"
}

variable "subnet_public_b_cidr" {
  description = "Subnet Public B CIDR"
}

variable "subnet_public_b_region" {
  description = "Subnet Public B Region"
}

variable "subnet_private_a_cidr" {
  description = "Subnet Private A CIDR"
}

variable "subnet_private_a_region" {
  description = "Subnet Private A Region"
}

variable "subnet_private_b_cidr" {
  description = "Subnet Private B CIDR"
}

variable "subnet_private_b_region" {
  description = "Subnet Private B Region"
}


variable "nat_ami" {
  description = "The Amazon Image used for NAT"
}

variable "nat_region" {
  description = "Region where the NAT instance will live"
}

variable "nat_instance_type" {
  description = "The instance type of the NAT machine"
}

variable "rds_identifier" {
  description = "Unique ID of the RDS instance"
}

variable "rds_allocated_storage" {
  description = "How much size will allocate the RDS instance"
}

variable "rds_engine" {
  description = "MySQL, MSSQL, Aurora, Oracle, MariaDB, etc"
}

variable "rds_engine_version" {
  description = "Version of the database engine"
}

variable "rds_instance_class" {
  description = "Type of the EC2 instance used to create the RDS"
}

variable "rds_db_name" {
  description = "Name of the Database"
}

variable "rds_port" {
  description = "Port in which the RDS instance will listen"
}

variable "rds_db_username" {}
variable "rds_db_password" {}
