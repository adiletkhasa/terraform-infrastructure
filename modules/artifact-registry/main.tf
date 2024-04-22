resource "google_artifact_registry_repository" "my-repo" {
  location      = var.artifact-config["location"]
  repository_id = var.artifact-config["repository_id"]
  description   = "example docker repository"
  format        = "DOCKER"
}