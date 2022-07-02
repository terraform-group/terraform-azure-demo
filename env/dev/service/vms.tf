resource "azurerm_linux_virtual_machine" "myserver" {
  for_each                        = toset(local.vms)
  name                            = each.value
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "Passwd123!"
  disable_password_authentication = false
  zone                            = local.vms_config[each.value]["zone"]
  network_interface_ids = [
    local.vms_config[each.value]["nic_id"]
  ]
  user_data = base64encode(file("${path.module}/config/install-nginx.sh"))

  os_disk {
    name                 = "disk-${each.value}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}