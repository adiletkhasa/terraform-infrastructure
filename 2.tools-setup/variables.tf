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

# variable configurations for Cert Manager helm chart deployment
variable "cert-manager-config" {
  type        = map(any)
  description = "Please define cert-manager helm chart version, and deployment_name "
  default = {
    deployment_name          = "cert-manager"
    chart_version            = "1.10.0"
  }
}

# variable configurations for Hashicorp Vault helm chart deployment

variable "vault-config" {
  type        = map(any)
  description = "Please define vault helm chart version, and deployment_name "
  default = {
    deployment_name          = "vault"
    chart_version            = "0.22.1"
  }
}

# variable configurations for argocd helm chart deployment
variable "prometheus-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "prometheus"
    chart_version   = "15.17.0"

  }
}

# variable configurations for argocd helm chart deployment
variable "grafana-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "grafana"
    chart_version   = "6.43.3"
    adminUser       = "admin"
    adminPassword   = "password"
  }
}