terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "4.1.0"
    }
  }
}

provider "keycloak" {
    client_id     = <%- "\""+keycloakClientId+"\"" %>
    username      = <%- "\""+keycloakAdminUser+"\"" %>
    password      = <%- "\""+keycloakAdminPassword+"\"" %>
    url           = <%- "\"http://kc."+domain+"\""%>
}