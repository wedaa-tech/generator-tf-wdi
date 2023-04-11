variable "cluster_name" {
  type    = string
  default = <%- "\""+clusterName+"\"" %>
}

variable "kubernetes_version" {
  type    = string
  default = "1.24"
}

variable "port" {
  type    = number
  default = <%- reactPort %>
}

variable "namespace" {
  type    = string
  default = <%- "\""+namespace+"\"" %>
}