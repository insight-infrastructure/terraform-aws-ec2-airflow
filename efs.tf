resource "aws_efs_file_system" "this" {
  count          = var.create_efs ? 1 : 0
  creation_token = var.name

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_efs_mount_target" "this" {
  count           = var.create_efs ? 1 : 0
  file_system_id  = join("", aws_efs_file_system.this.*.id)
  subnet_id       = local.subnet_id
  security_groups = [join("", aws_security_group.efs.*.id)]
}

resource "aws_security_group" "efs" {
  count       = var.create_efs ? 1 : 0
  name        = "${local.name}-efs-sg"
  description = "EFS Security Group"

  vpc_id = var.vpc_id == "" ? data.aws_vpc.default.id : var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "nfs_self" {
  count = var.create_efs ? 1 : 0

  description       = "NFS port with self"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  self              = true
  security_group_id = join("", aws_security_group.efs.*.id)
  type              = "ingress"
}
