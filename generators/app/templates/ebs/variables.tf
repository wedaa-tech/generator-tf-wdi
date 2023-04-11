variable "cluster_name" {
  type    = string
  default = <%- "\""+clusterName+"\"" %>
}

variable "region" {
  type    = string
  default = <%- "\""+awsRegion+"\"" %>
}
