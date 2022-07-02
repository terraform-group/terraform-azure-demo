output "subnet_ids" {
  value = [for k, v in azurerm_subnet.mysubnet : v.id]
}

output "vm_public_ips" {
  value = [for k, v in azurerm_public_ip.mypublicip : v.id]

}

output "mylb_public_ip" {
    value = azurerm_public_ip.mylbpublicip.id
  
}

output "vnet_id" {
    value = azurerm_virtual_network.mynetwork.id
  
}

output "nic_ids" {
    value = azurerm_network_interface.mynic.*.id
  
}