resource "aws_efs_file_system" "this" {
  creation_token = var.name

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_efs_mount_target" "this" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_id
  security_groups = var.vpc_security_group_ids
}
