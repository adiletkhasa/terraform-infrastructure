variable google_domain_name {
  type        = string
  default     = ""
  description = "domain name"
}

variable "PROJECT_ID" {}
variable "email" {}
variable "BUCKET_NAME" {}


# This block is used to setup ingress controller
variable "argo-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "argo"
    chart_version   = "5.20.5"

  }
}