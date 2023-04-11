variable "region" {
  type    = string
  default = <%- "\""+awsRegion+"\"" %>
}

variable "access_key" {
  type    = string
  default = <%- "\""+awsAccessKey+"\"" %>
}

variable "secret_key" {
  type    = string
  default = <%- "\""+awsSecretKey+"\"" %>
}
