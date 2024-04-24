module "cluster-autoscaler-terraform-helm" {
  source               = "../modules/terraform-helm/"
  deployment_name      = "cluster-autoscaler"
  deployment_namespace = "kube-system"
  chart                = "cluster-autoscaler"
  chart_version        = var.cluster-autoscaler-config["chart_version"]
  repository           = "https://kubernetes.github.io/autoscaler"
  values_yaml          = <<EOF

autoDiscovery:
  clusterName: ${var.gke_config["cluster_name"]}
  tags:
    - k8s.io/cluster-autoscaler/enabled
    - k8s.io/cluster-autoscaler/{{ .Values.autoDiscovery.clusterName }}
    - kubernetes.io/cluster/{{ .Values.autoDiscovery.clusterName }}
EOF
}