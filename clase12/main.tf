provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet"
  }

}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id

  tags = {
    Name = "Frontend"
  }
}

resource "aws_instance" "backend" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id

  tags = {
    Name = "Backend"
  }
}

resource "aws_db_instance" "db" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0.19"
    instance_class       = "db.t2.micro"
    name                 = "db"
    username             = "foo"
    password             = "foobarbaz"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
}