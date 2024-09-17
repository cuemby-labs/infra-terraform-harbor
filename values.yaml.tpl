hostname: harbor.${environment}.${domain_name}
expose:
  type: ingress
  ingress:
    annotations:
      ingress.kubernetes.io/proxy-body-size: "0"
      ingress.kubernetes.io/ssl-redirect: "true"
      nginx.ingress.kubernetes.io/proxy-body-size: "0"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
      cert-manager.io/issuer: origin-ca-issuer
      cert-manager.io/issuer-kind: OriginIssuer
      cert-manager.io/issuer-group: cert-manager.k8s.cloudflare.com
      external-dns.alpha.kubernetes.io/cloudflare-proxied: "true"
    harbor:
      annotations:
        external-dns.alpha.kubernetes.io/hostname: harbor.${environment}.${domain_name}
    notary:
      annotations:
        external-dns.alpha.kubernetes.io/hostname: notary.${environment}.${domain_name}
    hosts:
      core: harbor.${environment}.${domain_name}
      notary: notary.${environment}.${domain_name}
    className: nginx
  tls:
    enabled: true
    certSource: secret
    secret:
      secretName: "harbor-${dash_domain_name}"
      notarySecretName: "notary-${dash_domain_name}"
externalURL: https://harbor.${environment}.${domain_name}
harborAdminPassword: ${harbor_admin_password}
