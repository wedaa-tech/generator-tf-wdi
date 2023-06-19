<%_ if (cloudProvider == "aws") { _%>
variable "region" {
  type    = string
  default = <%- "\""+awsRegion+"\"" %>
}
<%_ } _%>
<%_ if (cloudProvider == "azure") { _%>
variable "location" {
  type    = string
  default = <%- "\""+location+"\"" %>
}
<%_ } _%>