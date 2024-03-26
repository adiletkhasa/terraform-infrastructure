variable "annotations" {
  type = map(any)
  default = {
    name = "example-annotation"
  }
}

variable "labels" {
  type = map(any)
  default = {
    name = "example-annotation"
  }
}

variable "name" {
  type    = string
  default = "terraform"
} 