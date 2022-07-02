resource "azurerm_network_interface" "mynic" {
  count               = length(local.vms)
  name                = "nic-${local.vms[count.index]}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = [for k, v in azurerm_subnet.mysubnet : v.id][count.index]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = [for k, v in azurerm_public_ip.mypublicip : v.id][count.index]
  }
}