
output "bastion_public_ip" {
  value = module.instance.public_ip
}

output "bastion_private_ip" {
  value = module.instance.private_ip
}