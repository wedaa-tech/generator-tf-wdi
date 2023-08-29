<%_ if (onCloud) { _%>
terraform {
 required_providers {
<%_ if (cloudProvider == "aws") { _%>
    aws = {
    source = "hashicorp/aws"
    }
<%_ } _%>
<%_ if (cloudProvider == "azure") { _%>
   azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.71.0"
    }
<%_ } _%>
<%_ if ( domain == "" ) { _%>
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
<%_ } _%>
 }
}
<%_ } _%>

provider "kubernetes" {
  config_path = "~/.kube/config"
}