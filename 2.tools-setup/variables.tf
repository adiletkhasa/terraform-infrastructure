variable google_domain_name {
  type        = string
  default     = ""
  description = "domain name"
}

variable "PROJECT_ID" {}
variable "email" {}
variable "BUCKET_NAME" {}


# variable configurations for argocd helm chart deployment
variable "argo-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "argo"
    chart_version   = "5.20.5"

  }
}

# variable configurations for Ingress-Controller helm chart deployment
variable "ingress-controller-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name          = "ingress-controller"
    chart_version            = "4.3.0"
    loadBalancerSourceRanges = "0.0.0.0/0"
  }
}

# variable configurations for Ingress-Controller helm chart deployment
variable "external-dns-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name          = "external-dns"
    chart_version            = "6.11.3"
  }
}