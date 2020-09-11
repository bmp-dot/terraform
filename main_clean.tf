provider "nutanix" {
 username = "admin"
 password = "xxxxxx"
 endpoint = "xxx.xxx.xxx.xxx"
 insecure = true
}

resource "nutanix_virtual_machine" "demo-01-web-terraform-pool" {
 name = "demo-01-web-terraform-pool"
 description = "Created with Terraform"
 provider = nutanix
 cluster_uuid = "0005842a-4b74-b4fc-0000-000000014b60"
  num_vcpus_per_socket = 1
  num_sockets = 1
  memory_size_mib = 2048

  nic_list {
     # subnet_reference UUID
     subnet_uuid = "0f4ece03-7d4f-4303-b36d-80493150847d"
   }

  disk_list {
  # data_source_reference UUID
  data_source_reference = {
   kind = "image"
   uuid = "a757e7cd-a320-4a11-8b7f-fa7020e4b6e7"
    }

  device_properties {
    disk_address = {
   device_index = 0
   adapter_type = "SCSI"
    }

    device_type = "DISK"
  }
   }

  disk_list {
  # defining an additional entry in the disk_list array will create another.
  #disk_size_mib and disk_size_bytes must be set together.
  disk_size_mib   = 100000
  disk_size_bytes = 104857600000
   }
}

output "ip_address_web" {
  value = nutanix_virtual_machine.demo-01-web-terraform-pool.nic_list_status.0.ip_endpoint_list[0]["ip"]
}

####

resource "nutanix_virtual_machine" "demo-01-db-terraform-pool" {
 name = "demo-01-db-terraform-pool"
 description = "Created with Terraform"
 provider = nutanix
 cluster_uuid = "0005842a-4b74-b4fc-0000-000000014b60"
  num_vcpus_per_socket = 1
  num_sockets = 1
  memory_size_mib = 2048

  nic_list {
     # subnet_reference UUID
     subnet_uuid = "0f4ece03-7d4f-4303-b36d-80493150847d"
   }

  disk_list {
  # data_source_reference UUID
  data_source_reference = {
   kind = "image"
   uuid = "a757e7cd-a320-4a11-8b7f-fa7020e4b6e7"
    }

  device_properties {
    disk_address = {
   device_index = 0
   adapter_type = "SCSI"
    }

    device_type = "DISK"
  }
   }

  disk_list {
  # defining an additional entry in the disk_list array will create another.
  #disk_size_mib and disk_size_bytes must be set together.
  disk_size_mib   = 100000
  disk_size_bytes = 104857600000
   }
}

output "ip_address_db" {
  value = nutanix_virtual_machine.demo-01-db-terraform-pool.nic_list_status.0.ip_endpoint_list[0]["ip"]
}


####


resource "nutanix_virtual_machine" "demo-01-app-terraform-pool" {
 name = "demo-01-app-terraform-pool"
 description = "Created with Terraform"
 provider = nutanix
 cluster_uuid = "0005842a-4b74-b4fc-0000-000000014b60"
  num_vcpus_per_socket = 1
  num_sockets = 1
  memory_size_mib = 2048

  nic_list {
     # subnet_reference UUID
     subnet_uuid = "0f4ece03-7d4f-4303-b36d-80493150847d"
   }

  disk_list {
   # data_source_reference UUID
  data_source_reference = {
   kind = "image"
   uuid = "a757e7cd-a320-4a11-8b7f-fa7020e4b6e7"
    }

  device_properties {
    disk_address = {
   device_index = 0
   adapter_type = "SCSI"
    }

    device_type = "DISK"
  }
   }

  disk_list {
  # defining an additional entry in the disk_list array will create another.
  #disk_size_mib and disk_size_bytes must be set together.
  disk_size_mib   = 100000
  disk_size_bytes = 104857600000
   }
}

output "ip_address_app" {
  value = nutanix_virtual_machine.demo-01-app-terraform-pool.nic_list_status.0.ip_endpoint_list[0]["ip"]
}



