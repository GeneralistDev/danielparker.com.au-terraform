provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "example" {
  name = "allow_all"
  description = "Allow all traffic"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.example.id}"
}

resource "aws_instance" "example" {
  ami = "ami-db7b39e1"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.example.id}"]
  subnet_id = "${aws_subnet.example.id}"
}
