resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.namespace
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}
resource "helm_release" "harbor" {
  name       = var.release_name
  namespace  = var.namespace

  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  version    = var.chart_version

  values     = [file("${path.module}/values.yaml")]
}
locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}