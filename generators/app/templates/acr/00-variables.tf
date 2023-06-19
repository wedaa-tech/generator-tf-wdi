variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  type        = string
  default     = <%- "\""+"rg-"+projectName+"\"" %>
}

variable "cluster_name" {
  description = "Name of AKS cluster."
  type        = string
  default     = <%- "\""+clusterName+"\"" %> 
}

variable "acr_name" {
  description = "Name of the azure container registry."
  type        = string
  default     = <%- "\""+"acr"+projectName+"\"" %> 
}

variable "location" {
  description = "Location (Azure Region)."
  type    = string
  default = <%- "\""+location+"\"" %>
}

variable "acr_sku" {
  type        = string
  description = "The SKU of the Azure Container Registry"
  default     = "Basic"
}
