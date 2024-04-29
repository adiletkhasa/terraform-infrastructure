module "ecom-terraform-k8s-namespace" {
  source = "../modules/terraform-k8s-namespace/"
  name   = "ecom"
}


module "ecom-terraform-helm" {
  source               = "../modules/terraform-helm-local/"
  deployment_name      = "ecom"
  deployment_namespace = module.ecom-terraform-k8s-namespace.namespace
  deployment_path      = "./charts/ecom"
  values_yaml          = <<EOF

image:
  repository: us-central1-docker.pkg.dev/terraform-project-akhasa1/docker-registry/simple-website
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: "4.0.0"

service:
  type: ClusterIP
  port: 5000

ingress:
  enabled: true
  className: "nginx"
  annotations: 
    ingress.kubernetes.io/ssl-redirect: "false"
    cert-manager.io/cluster-issuer: letsencrypt-dev 
    acme.cert-manager.io/http01-edit-in-place: "true"
    timestamp: "{{ now | quote }}"
  hosts:
    - host: "uat-ecom.${var.google_domain_name}"
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
   - secretName: chart-example-tls
     hosts:
       - "uat-ecom.${var.google_domain_name}"

  EOF
}