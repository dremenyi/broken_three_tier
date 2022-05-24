// defines outputs for the keys

output "bastion_keypair" {
  value = aws_key_pair.bastion.key_name
}

output "internal_keypair" {
  value = aws_key_pair.internal.key_name
}