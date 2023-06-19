
resource "azurerm_resource_group" "arg" {
  name     = var.resource_group_name
  location = var.location
}
######################################## VNET ######################################################
resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.location
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.arg.name
  dns_servers         = var.dns_servers
  tags                = var.tags

}

#################################### SUBNETS #########################################################

resource "azurerm_subnet" "vnet_subnets" {
  count = length(var.subnet_name)

  address_prefixes                               = [var.address_prefix[count.index]]
  name                                           = var.subnet_name[count.index]
  resource_group_name                            = azurerm_resource_group.arg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name

  dynamic "delegation" {
    for_each = lookup(var.subnet_delegation, var.subnet_name[count.index], {})

    content {
      name = delegation.key

    service_delegation {
      name    = lookup(delegation.value, "service_name",[])
      actions = lookup(delegation.value, "service_actions", [])
     }
    }
  }
}

#################################### NETWORK SECURITY GROUP ########################################

resource "azurerm_network_security_group" "nsg" {
  location            = var.location 
  name                = var.security_group_name
  resource_group_name = azurerm_resource_group.arg.name
  tags                = var.tags
  count               = var.num_rules

  security_rule {
    name                       = var.rule_configurations[count.index].name
    priority                   = var.rule_configurations[count.index].priority
    direction                  = var.rule_configurations[count.index].direction
    access                     = var.rule_configurations[count.index].access
    protocol                   = var.rule_configurations[count.index].protocol
    source_port_range          = var.rule_configurations[count.index].source_port_range
    destination_port_ranges    = var.rule_configurations[count.index].destination_port_ranges
    source_address_prefix      = var.rule_configurations[count.index].source_address_prefix
    destination_address_prefix = var.rule_configurations[count.index].destination_address_prefix
  }

  depends_on = [
      azurerm_subnet.vnet_subnets  
  ]
    
}

############################## NETWORK SECURITY GROUP SUBNET ASSOCIATION ###########################

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
  
  count = length(var.subnet_name)

  subnet_id                 = azurerm_subnet.vnet_subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
  depends_on = [
      azurerm_network_security_group.nsg  
  ]
}

################################# ROUTE TABLE FOR SUBNETS ##########################################

resource "azurerm_route_table" "route_1" {
  name                          = "Public-route-table"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.arg.name
  disable_bgp_route_propagation = false
  tags                          = var.tags

  route {
    name           = "route1"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
  depends_on = [
      azurerm_subnet_network_security_group_association.nsg_subnet_association  
  ]
}

################################ ROUTE TABLE SUBNET ASSOCIATION ###################################

resource "azurerm_subnet_route_table_association" "subnet_routtable_association" {
  count = length(var.subnet_name)
  route_table_id = azurerm_route_table.route_1.id
  subnet_id      = azurerm_subnet.vnet_subnets[count.index].id
  depends_on = [
      azurerm_route_table.route_1  
  ]
}


####################################################################################################
################################### KUBERNETES #####################################################

  resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.arg.name
  dns_prefix          = var.dns_prefix
  

  default_node_pool {
    name                   = var.apps_node_pool
    enable_auto_scaling    = var.enable_auto_scaling
    min_count              = var.min_count
    max_count              = var.max_count
    node_count             = var.node_count
    vm_size                = var.app_vm_size
    vnet_subnet_id         = azurerm_subnet.vnet_subnets[0].id
  }
  
   network_profile {
      network_plugin     = var.network_plugin
      network_policy     = var.network_policy
      dns_service_ip     = var.dns_service_ip
      service_cidr       = var.service_cidr
      docker_bridge_cidr = var.docker_bridge_cidr
      outbound_type      = var.outbound_type
    }

  identity {
    type = "SystemAssigned"
  }
 
  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  name                  = var.eck_node_pool
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.eck_vm_size
  node_count            = var.node_count
  vnet_subnet_id         = azurerm_subnet.vnet_subnets[0].id
}

