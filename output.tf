output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "network_security_group_name" {
  value = azurerm_network_security_group.nsg.name
}

output "network_interface_name" {
  value = azurerm_network_interface.nic.name
}

output "virtual_machine_name" {
  value = azurerm_virtual_machine.vm.name
}

output "ssh_private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "ssh_public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}
