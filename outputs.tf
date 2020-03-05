output "public_ip" {
  value = aws_eip.this.public_ip
}

output "instance_id" {
  value = aws_instance.this.id
}

output "key_name" {
  value = aws_key_pair.this.*.key_name[0]
}
