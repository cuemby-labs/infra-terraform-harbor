hostname: harbor.${domain_name}
expose:
  type: ingress
  ingress:
    annotations:
      ingress.kubernetes.io/proxy-body-size: "0"
      ingress.kubernetes.io/ssl-redirect: "true"
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
      cert-manager.io/issuer: ${issuer_name}
      cert-manager.io/issuer-kind: ${issuer_kind}
      cert-manager.io/issuer-group: cert-manager.k8s.cloudflare.com
      external-dns.alpha.kubernetes.io/cloudflare-proxied: "true"
    harbor:
      annotations:
        external-dns.alpha.kubernetes.io/hostname: harbor.${domain_name}
    notary:
      annotations:
        external-dns.alpha.kubernetes.io/hostname: notary.${domain_name}
    hosts:
      core: harbor.${domain_name}
      notary: notary.${domain_name}
    className: nginx
  tls:
    enabled: true
    certSource: secret
    secret:
      secretName: "harbor-${dash_domain_name}"
      notarySecretName: "notary-${dash_domain_name}"
externalURL: https://harbor.${domain_name}
harborAdminPassword: ${harbor_admin_password}
portal:
  resources:
    limits:
      cpu: ${jportal_limits_cpu}
      memory: ${portal_limits_memory}
    requests:
      cpu: ${portal_request_cpu}
      memory: ${portal_request_memory}
jobservice:
  resources:
    limits:
      cpu: ${jobservice_limits_cpu}
      memory: ${jobservice_limits_memory}
    requests:
      cpu: ${jobservice_request_cpu}
      memory: ${jobservice_request_memory}
registry:
  registry:
    resources:
      limits:
        cpu: ${registry_limits_cpu}
        memory: ${registry_limits_memory}
      requests:
        cpu: ${registry_request_cpu}
        memory: ${registry_request_memory}
trivy:
  resources:
    limits:
      cpu: ${trivy_limits_cpu}
      memory: ${trivy_limits_memory}
    requests:
      cpu: ${trivy_request_cpu}
      memory: ${trivy_request_memory}
redis:
  internal:
    resources:
      limits:
        cpu: ${redis_limits_cpu}
        memory: ${redis_limits_memory}
      requests:
        cpu: ${redis_request_cpu}
        memory: ${redis_request_memory}
database:
  internal:
    resources:
      limits:
        cpu: ${database_limits_cpu}
        memory: ${database_limits_memory}
      requests:
        cpu: ${database_request_cpu}
        memory: ${database_request_memory}
core:
  resources:
    limits:
      cpu: ${core_limits_cpu}
      memory: ${core_limits_memory}
    requests:
      cpu: ${core_request_cpu}
      memory: ${core_request_memory}