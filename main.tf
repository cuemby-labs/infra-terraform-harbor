#
# Harbor Resources
#

resource "kubernetes_namespace" "harbor" {
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "harbor" {
  name       = var.helm_release_name
  namespace  = var.namespace_name
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  version    = var.helm_chart_version

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      harbor_admin_password     = var.harbor_admin_password,
      domain_name               = var.domain_name,
      dash_domain_name          = var.dash_domain_name,
      issuer_name               = var.issuer_name,
      issuer_kind               = var.issuer_kind,
      portal_request_memory     = var.resources["portal"]["requests"]["memory"],
      portal_limits_memory      = var.resources["portal"]["limits"]["memory"],
      portal_request_cpu        = var.resources["portal"]["requests"]["cpu"],
      portal_limits_cpu         = var.resources["portal"]["limits"]["cpu"],
      jobservice_request_memory = var.resources["jobservice"]["requests"]["memory"],
      jobservice_limits_memory  = var.resources["jobservice"]["limits"]["memory"],
      jobservice_request_cpu    = var.resources["jobservice"]["requests"]["cpu"],
      jobservice_limits_cpu     = var.resources["jobservice"]["limits"]["cpu"],
      registry_request_memory   = var.resources["registry"]["requests"]["memory"],
      registry_limits_memory    = var.resources["registry"]["limits"]["memory"],
      registry_request_cpu      = var.resources["registry"]["requests"]["cpu"],
      registry_limits_cpu       = var.resources["registry"]["limits"]["cpu"],
      trivy_request_memory      = var.resources["trivy"]["requests"]["memory"],
      trivy_limits_memory       = var.resources["trivy"]["limits"]["memory"],
      trivy_request_cpu         = var.resources["trivy"]["requests"]["cpu"],
      trivy_limits_cpu          = var.resources["trivy"]["limits"]["cpu"],
      redis_request_memory      = var.resources["redis"]["requests"]["memory"],
      redis_limits_memory       = var.resources["redis"]["limits"]["memory"],
      redis_request_cpu         = var.resources["redis"]["requests"]["cpu"],
      redis_limits_cpu          = var.resources["redis"]["limits"]["cpu"],
      database_request_memory   = var.resources["database"]["requests"]["memory"],
      database_limits_memory    = var.resources["database"]["limits"]["memory"],
      database_request_cpu      = var.resources["database"]["requests"]["cpu"],
      database_limits_cpu       = var.resources["database"]["limits"]["cpu"],
      core_request_memory       = var.resources["core"]["requests"]["memory"],
      core_limits_memory        = var.resources["core"]["limits"]["memory"],
      core_request_cpu          = var.resources["core"]["requests"]["cpu"],
      core_limits_cpu           = var.resources["core"]["limits"]["cpu"],
    })
  ]
}

#
# Walrus Information
#

locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}