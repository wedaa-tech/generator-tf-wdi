<%_ if (cloudProvider == "aws") { _%>
variable "cluster_name" {
  type    = string
  default = <%- "\""+clusterName+"\"" %>
}
<%_ } _%>
<%_ if (cloudProvider == "azure") { _%>
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
<%_ } _%>
