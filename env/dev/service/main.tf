data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "terraform-demo"
    storage_account_name = "tfstateadmin111"
    container_name       = "tfstate"
    key                  = "env/dev/network/terraform-network.tfstate"
  }
}

locals {
  vms = ["server01", "server02"]
  vms_config = {
    server01 = {
      zone      = "1",
      subnet_id = data.terraform_remote_state.network.outputs["subnet_ids"][0]
      publicip  = data.terraform_remote_state.network.outputs["vm_public_ips"][0]
      nic_id    = data.terraform_remote_state.network.outputs["nic_ids"][0]
    },
    server02 = {
      zone      = "2"
      subnet_id = data.terraform_remote_state.network.outputs["subnet_ids"][1]
      publicip  = data.terraform_remote_state.network.outputs["vm_public_ips"][1]
      nic_id    = data.terraform_remote_state.network.outputs["nic_ids"][1]
    }
  }
  mylb_public_ip = data.terraform_remote_state.network.outputs["mylb_public_ip"]
  vnet_id        = data.terraform_remote_state.network.outputs["vnet_id"]
}