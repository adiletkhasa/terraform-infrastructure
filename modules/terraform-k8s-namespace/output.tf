output "kubernetes_namespace" {
  value = kubernetes_namespace.example.id
}
output "namespace" {
  value = kubernetes_namespace.example.metadata[0].name
}