variable "deployment_name" {
  type        = string
  description = "- (Required) Chart release name."
}

variable "deployment_namespace" {
  type        = string
  default     = "default"
  description = "- (Optional) Namespace where to deploy resources to."
}

variable "repository" {
  type        = string
  description = "- (Required) Path for the Chart."
}

variable "chart" {
  type        = string
  description = "- (Required) Path for the Chart."
}
variable "values_yaml" {
  type        = string
  description = "- (Required) Values.yaml file."
}
variable "chart_version" {
  type        = string
  description = "Version information"
  default     = ""
}