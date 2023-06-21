variable "cluster_name" {
  type    = string
  default = <%- "\""+clusterName+"\"" %>
}

variable "kubernetes_version" {
  type    = string
  default = "1.26" 
}

variable "region" {
  type    = string
  default = <%- "\""+awsRegion+"\"" %>
}

variable "project_name" {
  type        = string
  default = <%- "\""+projectName+"\"" %>
}