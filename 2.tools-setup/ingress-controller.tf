module "ingress-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "ingress"
}

module "ingress-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "ingress"
  deployment_namespace = module.ingress-terraform-k8s-namespace.namespace
  chart                = "ingress-nginx"
  chart_version        = var.ingress-controller-config["chart_version"]
  repository           = "https://kubernetes.github.io/ingress-nginx"
  values_yaml          = <<EOF
controller:
  service:
    create: true
    type: LoadBalancer
    loadBalancerSourceRanges: [
        "${var.ingress-controller-config["loadBalancerSourceRanges"]}",
    ]
  EOF
}