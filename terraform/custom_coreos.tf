provider "aws" {}

variable "account" {}
variable "subnet_id" {}
variable "iam_instance_profile" {}
variable "security_group" {}

data "aws_ami" "ami" {
  most_recent = true
  name_regex = "^custom-coreos \\d{10}"
  owners = ["${var.account}"]
}

resource "aws_instance" "ami_test" {
  ami                    = "${data.aws_ami.ami.id}"
  subnet_id              = "${var.subnet_id}"
  instance_type          = "c4.xlarge"
  key_name               = "geowa4"
  vpc_security_group_ids = ["${var.security_group}"]
  private_ip             = "172.19.5.199"
  iam_instance_profile   = "${var.iam_instance_profile}"
  tags {
    Name = "AMI Test"
  }
}

resource "aws_eip" "ip" {
  vpc = true
}

resource "aws_eip_association" "ip_assoc" {
  instance_id   = "${aws_instance.ami_test.id}"
  allocation_id = "${aws_eip.ip.id}"
}

output "public_ip" {
  value = "${aws_eip.ip.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.ami_test.private_ip}"
}
