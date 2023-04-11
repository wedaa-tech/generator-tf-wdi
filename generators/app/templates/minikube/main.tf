resource "kubernetes_namespace" "wdi" {
  metadata {
    name = <%- "\""+namespace+"\"" %> # Provide namespace here, default is "wdi"
  }
}