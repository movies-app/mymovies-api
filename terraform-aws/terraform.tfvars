aws_region     = "us-east-1"

vpc_cidr_block = "10.2.0.0/16"

subnet_public_a_cidr = "10.2.0.0/24"
subnet_public_a_region = "us-east-1a"

subnet_public_b_cidr = "10.2.1.0/24"
subnet_public_b_region = "us-east-1b"

subnet_private_a_cidr = "10.2.2.0/28"
subnet_private_a_region = "us-east-1d"

subnet_private_b_cidr = "10.2.2.32/28"
subnet_private_b_region = "us-east-1e"

nat_ami           = "ami-224dc94a"
nat_instance_type = "m1.small"
nat_region        = "us-east-1a"

rds_identifier        = "movies-db"
rds_allocated_storage = 5
rds_engine            = "mysql"
rds_engine_version    = "5.6.27"
rds_instance_class    = "db.t2.micro"
rds_db_name           = "movies"
rds_port              = 3306