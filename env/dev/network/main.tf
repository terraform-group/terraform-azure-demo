locals {
  subnet_names = ["mysubnet-1", "mysubnet-2"]
  subnet_config = {
    mysubnet-1 = {
      address_prefixes = "10.0.1.0/24"
    },
    mysubnet-2 = {
      address_prefixes = "10.0.2.0/24"
    }
  }
  vms = ["server01", "server02"]
  vms_config = {
    server01 = {
      public_ip_name = "publicip-server1"
    },
    server02 = {
      public_ip_name = "publicip-server2"
    }
  }

  ports = [
    {
      port     = "80"
      priority = 100
    },
    {
      port     = "22"
      priority = 101
    },
    {
      port     = "443"
      priority = 102
    }
  ]

}