output "k8s_information" {
  value = <<-EOF
${google_container_cluster.primary.name}
    EOF
}