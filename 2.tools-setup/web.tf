module "web-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "web"
}


module "api-terraform-helm" {
  source               = "../modules/terraform-helm-local/"
  deployment_name      = "api"
  deployment_namespace = module.web-terraform-k8s-namespace.namespace
  deployment_path      = "./charts/web"
  values_yaml          = <<EOF

image:
  repository: us-central1-docker.pkg.dev/woven-surface-428821-q5/docker-registry/api
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: "latest"

service:
  type: ClusterIP
  port: 3000

ingress:
  enabled: true
  className: "nginx"
  annotations: 
    ingress.kubernetes.io/ssl-redirect: "false"
    cert-manager.io/cluster-issuer: letsencrypt-dev 
    acme.cert-manager.io/http01-edit-in-place: "true"
    timestamp: "{{ now | quote }}"
  hosts:
    - host: "api.${var.google_domain_name}"
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
   - secretName: chart-example-tls
     hosts:
       - "api.${var.google_domain_name}"

  EOF
}