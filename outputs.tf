output "public_ip" {
  value       = join("", aws_eip.this.*.public_ip)
  description = "The public IP of the instance created"
}

output "instance_id" {
  value       = join("", aws_instance.this.*.id)
  description = "The instance ID created"
}

output "instance_profile" {
  value       = join("", aws_iam_instance_profile.this.*.id)
  description = "The instance profile id"
}

output "instance_profile_name" {
  value       = join("", aws_iam_instance_profile.this.*.name)
  description = "The instance profile name"
}

output "key_name" {
  value       = join("", aws_key_pair.this.*.key_name)
  description = "The key pair name created"
}

output "dns_name" {
  value       = join("", aws_efs_file_system.this.*.dns_name)
  description = "EFS DNS name"
}

output "mount_target_ids" {
  value       = join("", aws_efs_mount_target.this.*.id)
  description = "List of EFS mount target IDs (one per Availability Zone)"
}