variable artifact-config {
  type        = map(any)
  description = "configurations for Artifact repo"
  default     = {
    location      = "us-central1"
    repository_id = "docker-registry"
  }
}