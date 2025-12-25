variable "dashboard_cluster_name" {
  description = "Cluster name that appears in the browser window title"
  type        = string
  default     = <%- "\""+clusterName+"\"" %>
}