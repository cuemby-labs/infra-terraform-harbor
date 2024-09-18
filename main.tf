#
# Harbor Resources
#

resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "harbor" {
  name       = var.release_name
  namespace  = var.namespace_name

  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  version    = var.chart_version

  # Ingress values
  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      harbor_admin_password = var.harbor_admin_password,
      domain_name           = var.domain_name,
      dash_domain_name      = var.dash_domain_name
    })
  ]
}

#
# Walrus information
#

locals {
  context = var.context
}