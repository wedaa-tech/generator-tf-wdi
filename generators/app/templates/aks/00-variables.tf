variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
  default     = <%- "\""+"rg-"+projectName+"\"" %>
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    APP = <%- "\""+projectName+"\"" %>
  }
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = <%- "\""+"vnet-"+projectName+"\"" %>
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "location" {
  description = "Location (Azure Region)."
  type    = string
  default = <%- "\""+location+"\"" %>
}

variable "security_group_name" {
  description = "Network security group name"
  type        = string
  default     = <%- "\""+"nsg-"+projectName+"\"" %>
}

variable "subnet_name" {
  description = "Name of the subnets."
  type        = list(string)
  default     = [
    <%- "\""+"public_subnet_"+clusterName+"_0\"," %>
    ]  
}

variable "address_prefix" {
  description = "Cidr block of the subnets."
  type        = list(string)
  default     = [
    "10.0.0.0/24",
  ]
}

variable "subnet_delegation" {
  description = "A map of subnet name to delegation block on the subnet"
  type        = map(map(any))
  default     = {}
}

variable "num_rules" {
  type    = number
  default = 1
}

variable "rule_configurations" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(number)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "AllowInternetInBound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = [80, 443, 5601, 9200, 15021]
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    }
  ]
}

################################# KUBERNETES #######################################################

variable "cluster_name" {
  description = "Name of AKS cluster."
  type        = string
  default     = <%- "\""+clusterName+"\"" %> 
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster."
  type        = string
  default     = "tic" 
}

variable "kubernetes_version" {
  description = "kubernetes version"
  type        = string
  default     = "1.25.6"
}

variable "network_plugin" {
  description = "network plugin to use for networking (azure or kubenet)"
  type        = string
  default     = "azure"

  validation {
    condition = (
      var.network_plugin == "kubenet" ||
      var.network_plugin == "azure"
    )
    error_message = "Network Plugin must set to kubenet or azure."

  }
}

variable "dns_service_ip" {
  type        = string
  default     = "10.0.24.10"
}

variable "service_cidr" {
  type        = string
  default     = "10.0.24.0/24"
}

variable "docker_bridge_cidr" {
  type        = string
  default     = "172.17.0.1/16"
}

variable "outbound_type" {
  description = "outbound (egress) routing method which should be used for this Kubernetes Cluster"
  type        = string
  default     = "loadBalancer"
}

variable "private_cluster_enabled" {
  description = "Private Cluster"
  type = string
  default = "false"
}

variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI."
  type        = string
  default     = "azure"

  validation {
    condition = (
      (var.network_policy == null) ||
      (var.network_policy == "azure") ||
      (var.network_policy == "calico")
    )
    error_message = "Network pollicy must be azure or calico."
  }
}

variable "eck_node_pool" {
  description = "name of the eck node pool."
  type        = string
  default     = "ecknodepool" 
}

variable "apps_node_pool" {
  description = "name of the apps node pool."
  type        = string
  default     = "appnodepool" 
}
variable "node_count" {
  description = "node pool count."
  type        = number
  default     = "1"
}
variable "eck_vm_size" {
  description = "size of the vm."
  type        = string
  default     = "standard_b2ms"
}

variable "app_vm_size" {
  description = "size of the vm."
  type        = string
  default     = "standard_b4ms"
}

variable "enable_auto_scaling" {
  description = " enabling auto scaling for cluster."
  type        = bool
  default     = "true" 
}

variable "min_count" {
  description = "minimum count for cluster."
  type        = number
  default     = "1" 
}
variable "max_count" {
  description = "maximum count for cluster."
  type        = number
  default     = "3" 
}
