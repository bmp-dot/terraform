terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = "1.2.0"
    }
  }
}

provider "nutanix" {
  username = var.username
  password = var.password
  endpoint = <PC address> 
  insecure = true
}

variable "kubernetes_version" {
  default = "1.19.8-0"
}

variable "username" {  
  description = "username"  
  type        = string  
  sensitive   = true
}

variable "password" {  
  description = "password"  
  type        = string  
  sensitive   = true
}


resource "nutanix_karbon_cluster" "example_dev_cluster" {
  name    = "terraform-test"
  version = var.kubernetes_version
  storage_class_config {
    reclaim_policy = "Delete"
    volumes_config {
      file_system = "ext4"
      flash_mode  = false
      prism_element_cluster_uuid = <PE UUID>
      storage_container          = <PE CONTAINER NAME>
      username                   = var.username
      password                   = var.password

    }
  }
  cni_config {
    node_cidr_mask_size = 24
    pod_ipv4_cidr       = "172.20.0.0/16"
    service_ipv4_cidr   = "172.19.0.0/16"
  }
  worker_node_pool {
    node_os_version = "ntnx-1.0"
    num_instances   = 1
    ahv_config {
      network_uuid               = <SUBNET UUID>
      prism_element_cluster_uuid = <PE UUID>
      cpu = 8
      memory_mib = 8192
      disk_mib = 122880
    }
  }
  etcd_node_pool {
    node_os_version = "ntnx-1.0"
    num_instances   = 1
    ahv_config {
      network_uuid               = <SUBNET UUID>
      prism_element_cluster_uuid = <PE UUID>
      cpu = 4
      memory_mib = 8192
      disk_mib = 40960
    }
  }
  master_node_pool {
    node_os_version = "ntnx-1.0"
    num_instances   = 1
    ahv_config {
      network_uuid               = <SUBNET UUID>
      prism_element_cluster_uuid = <PE UUID>
      cpu = 2
      memory_mib = 4096
      disk_mib = 122880
    }
  }
}





