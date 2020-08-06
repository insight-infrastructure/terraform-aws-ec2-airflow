//
//resource "aws_default_vpc" "this" {}
//
//data "aws_vpc" "default" {
//  default = true
//  tags    = var.tags
//}
//
//data "aws_subnet_ids" "default" {
//  vpc_id = data.aws_vpc.default.id
//}
//
//data "aws_subnet" "this" {
//  count = length(data.aws_subnet_ids.default.ids)
//  id    = tolist(data.aws_subnet_ids.default.ids)[count.index]
//}
//
//data "aws_subnet" "custom" {
//  count = var.subnet_id != "" ? 1 : 0
//  id    = var.subnet_id
//}
//
//locals {
//  subnet_id = var.subnet_id != "" ? var.subnet_id : data.aws_subnet.this.*.id[var.az_num]
//  vpc_id = var.subnet_id != "" ? join("", data.aws_subnet.custom.*.vpc_id) : data.aws_vpc.default.id
//}
//
//variable "disable_create_security_group" {
//  description = "Bool to not create security group."
//  type = bool
//  default = true
//}
//
//resource "aws_security_group" "this" {
//  count = var.disable_create_security_group ? 0 : 1
//
//  vpc_id = local.vpc_id
//
//  egress {
//    from_port = 0
//    to_port   = 0
//    protocol  = "-1"
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//}
//
//resource "aws_security_group_rule" "ssh" {
//  count = var.disable_create_security_group ? 0 : 1
//  from_port = 22
//  to_port = 22
//  protocol = "tcp"
//  security_group_id = join("", aws_security_group.this.*.id)
//  type = "ingress"
//  cidr_blocks = ["0.0.0.0/0"]
//}
//
//resource "aws_security_group_rule" "secondary_http" {
//  count = var.disable_create_security_group ? 0 : 1
//  from_port = 8080
//  to_port = 8080
//  protocol = "tcp"
//  security_group_id = join("", aws_security_group.this.*.id)
//  type = "ingress"
//  cidr_blocks = ["0.0.0.0/0"]
//}
//
//resource "aws_security_group_rule" "nfs" {
//  count = var.disable_create_security_group ? 0 : 1
//  from_port = 2049
//  to_port = 2049
//  protocol = "tcp"
//  security_group_id = join("", aws_security_group.this.*.id)
//  type = "ingress"
//  cidr_blocks = ["0.0.0.0/0"]
//}
