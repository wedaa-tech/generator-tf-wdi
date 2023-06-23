<%_ if (onCloud == "true") { _%>
variable "cluster_name" {
  type    = string
  default = <%- "\""+clusterName+"\"" %>
}
<%_ } _%>