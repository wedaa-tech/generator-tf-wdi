terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.1.0"
    }
    <% if (kubernetes) { %>
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }<% } %>
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
