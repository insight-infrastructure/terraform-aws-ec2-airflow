module "ami" {
  source = "github.com/insight-infrastructure/terraform-aws-ami.git?ref=v0.1.0"
}

resource "aws_eip" "this" {
  tags = var.tags
}

resource "aws_eip_association" "this" {
  instance_id = aws_instance.this.id
  public_ip   = aws_eip.this.public_ip
}

resource "aws_key_pair" "this" {
  count      = var.public_key_path == "" ? 0 : 1
  public_key = file(var.public_key_path)
  tags       = var.tags
}

resource "aws_instance" "this" {
  ami           = module.ami.ubuntu_1804_ami_id
  instance_type = var.instance_type

  user_data = var.user_data != "" ? var.user_data : var.user_data_file_path != "" ? file(var.user_data_file_path) : ""

  //  subnet_id              = local.subnet_id
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.public_key_path == "" ? var.key_name : aws_key_pair.this.*.key_name[0]
  iam_instance_profile   = aws_iam_instance_profile.this.id

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = var.tags
}


module "ansible" {
  source           = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.8.0"
  ip               = aws_eip_association.this.public_ip
  user             = "ubuntu"
  private_key_path = var.private_key_path

  playbook_file_path = "${path.module}/ansible/main.yml"
  playbook_vars = merge({
    file_system_id = aws_efs_file_system.this.id,
  }, var.playbook_vars)

  requirements_file_path = "${path.module}/ansible/requirements.yml"
}
