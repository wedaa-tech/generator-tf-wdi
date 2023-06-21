variable "region" {
  type    = string
  default = <%- "\""+awsRegion+"\"" %>
}

variable "project_name" {
  type        = string
  default = <%- "\""+projectName+"\"" %>
}