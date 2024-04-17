### This repo is used to deploy namespaces

---
### Usage: 
---

1. Configure backend
```
source ../scripts/setenv.sh
```

#### 2. Initialize terraform 
```
terraform  init 
```
#### 3. Create 
```
terraform apply    -var-file ../0.account_setup/configurations.tfvars 
```


---
## Verification Proccess.


### Prometheus 
```
kubectl get pods -n prometheus 
kubectl get ingress -n prometheus
```

### Grafana 
```
kubectl get pods -n grafana 
kubectl get ingress -n grafana
```

### cert-manager 
```
kubectl get pods -n cert-manager 
```

### metrics-server
```
kubectl get pods -n kube-system
```

### External DNS 
```
kubectl get pods -n default 
On Console >> Cloud DNS >> hosted-zone >> Check records
```


### Check logs of external-dns
```
kubectl get pods -n external-dns 
kubectl logs POD_NAME -n external-dns
```

----
### Troubleshooting cert-manager
#### Sometimes when you visit the URL, it complains that certificate is not valid. Run below command and verify it is referring to the right clusterissuer
```
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces
```
---
### When above command ran, you should check for certificate readiness, and validity. 


----
### Troubleshooting certificate issue (https://)
#### Usually this issue happens when certificate is not ready. When you run below command it tells if certificate is Ready=True or Ready=False. Start by running below command. When you run 
```
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces
```

If the certificate request is not ready like below
```
certificaterequest.cert-manager.io/grafana-tls-zz84p   True                False    letsencrypt-prod  
```
#### then the error is related to ClusterIssuer. 
#### Steps two fix it
1. run 
```
kubectl get clusterissuer
kubectl describe clusterissuer
kubectl get certificaterequest -n NAMESPACE
kubectl certificaterequest grafana-tls-zz84p  -n NAMESPACE
```
#### if the clusterissuer is not working, you can rebuild it. 
```
cd 2.tools-setup
terraform state list 
terraform taint module.lets-encrypt.helm_release.helm_deployment
source ../scripts/setenv.sh
terraform apply -var-file ../0.account_setup/configurations.tfvars
```

