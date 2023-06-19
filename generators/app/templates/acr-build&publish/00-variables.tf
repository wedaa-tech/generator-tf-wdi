variable "acr_name" {
  description = "Name of the resource group to be imported."
  type        = string
  default     = <%- "\""+"acr"+projectName+"\"" %> 
}
