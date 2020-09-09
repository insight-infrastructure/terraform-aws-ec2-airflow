resource "random_pet" "this" {}

data "aws_region" "this" {}

locals {
  name = var.name == "" ? "harmony-validator-${random_pet.this.id}" : var.name
}

#########
# Network
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "default" {
  count = length(data.aws_subnet_ids.default.ids)
  id    = tolist(data.aws_subnet_ids.default.ids)[count.index]
}

locals {
  vpc_security_group_ids = compact(concat(
    [join("", aws_security_group.this.*.id)],
    [join("", aws_security_group.efs.*.id)],
  var.additional_security_groups))

  //  If no subnet, use a subnet index as EFS needs direct subnet ref to be in same AZ
  subnet_id = var.subnet_id == null ? data.aws_subnet.default.*.id[var.subnet_num] : var.subnet_id
}

resource "null_resource" "is_array_length_correct" {
  count = var.subnet_id == null && var.vpc_id == "" || var.subnet_id != "" && var.vpc_id != "" ? 0 : 1

  provisioner "local-exec" {
    command = "both vpc_id and subnet_id must be filled in together"
  }
}

############
# Elastic IP
resource "aws_eip" "this" {
  count = var.create ? 1 : 0
  tags  = var.tags
}

resource "aws_eip_association" "this" {
  count       = var.create ? 1 : 0
  instance_id = join("", aws_instance.this.*.id)
  public_ip   = join("", aws_eip.this.*.public_ip)
}

#####
# EC2
module "ami" {
  source = "github.com/insight-infrastructure/terraform-aws-ami.git?ref=v0.1.0"
}

resource "aws_key_pair" "this" {
  count      = var.create && var.public_key_path != "" ? 1 : 0
  public_key = file(var.public_key_path)
  tags       = var.tags
}

resource "aws_instance" "this" {
  count = var.create ? 1 : 0

  instance_type = var.instance_type
  user_data     = var.user_data != "" ? var.user_data : var.user_data_file_path != "" ? file(var.user_data_file_path) : ""

  ami                    = module.ami.ubuntu_1804_ami_id
  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.vpc_security_group_ids
  iam_instance_profile   = join("", aws_iam_instance_profile.this.*.id)

  key_name = concat(aws_key_pair.this.*.key_name, [
  var.key_name])[0]
  monitoring = var.monitoring_enabled

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = merge({
    Name : var.name
  }, var.tags)
}

#########
# Ansible
module "ansible" {
  create           = var.create
  source           = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.13.0"
  ip               = join("", aws_eip_association.this.*.public_ip)
  user             = "ubuntu"
  private_key_path = var.private_key_path

  playbook_file_path = "${path.module}/ansible/main.yml"
  playbook_vars = merge({
    file_system_id = join("", aws_efs_file_system.this.*.id),
  }, var.playbook_vars)

  requirements_file_path = "${path.module}/ansible/requirements.yml"
}
