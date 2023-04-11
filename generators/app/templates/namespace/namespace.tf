resource "kubernetes_namespace" "wdi" {
  metadata {
    name = <%- "\""+namespace+"\"" %> 
  }
}