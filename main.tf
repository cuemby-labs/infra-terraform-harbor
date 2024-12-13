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
      dash_domain_name          = local.dash_domain_name,
      issuer_name               = var.issuer_name,
      issuer_kind               = var.issuer_kind,
      portal_request_memory     = var.resources["portal"]["requests"]["memory"],
      portal_limits_memory      = var.resources["portal"]["limits"]["memory"],
      portal_request_cpu        = var.resources["portal"]["requests"]["cpu"],
      portal_limits_cpu         = var.resources["portal"]["limits"]["cpu"],
      portal_replicas           = var.replicas.portal,
      jobservice_request_memory = var.resources["jobservice"]["requests"]["memory"],
      jobservice_limits_memory  = var.resources["jobservice"]["limits"]["memory"],
      jobservice_request_cpu    = var.resources["jobservice"]["requests"]["cpu"],
      jobservice_limits_cpu     = var.resources["jobservice"]["limits"]["cpu"],
      jobservice_replicas       = var.replicas.jobservice,
      registry_request_memory   = var.resources["registry"]["requests"]["memory"],
      registry_limits_memory    = var.resources["registry"]["limits"]["memory"],
      registry_request_cpu      = var.resources["registry"]["requests"]["cpu"],
      registry_limits_cpu       = var.resources["registry"]["limits"]["cpu"],
      registry_replicas         = var.replicas.registry,
      trivy_request_memory      = var.resources["trivy"]["requests"]["memory"],
      trivy_limits_memory       = var.resources["trivy"]["limits"]["memory"],
      trivy_request_cpu         = var.resources["trivy"]["requests"]["cpu"],
      trivy_limits_cpu          = var.resources["trivy"]["limits"]["cpu"],
      trivy_replicas            = var.replicas.trivy,
      redis_request_memory      = var.resources["redis"]["requests"]["memory"],
      redis_limits_memory       = var.resources["redis"]["limits"]["memory"],
      redis_request_cpu         = var.resources["redis"]["requests"]["cpu"],
      redis_limits_cpu          = var.resources["redis"]["limits"]["cpu"],
      redis_replicas            = var.replicas.redis,
      database_request_memory   = var.resources["database"]["requests"]["memory"],
      database_limits_memory    = var.resources["database"]["limits"]["memory"],
      database_request_cpu      = var.resources["database"]["requests"]["cpu"],
      database_limits_cpu       = var.resources["database"]["limits"]["cpu"],
      database_replicas         = var.replicas.database,
      core_request_memory       = var.resources["core"]["requests"]["memory"],
      core_limits_memory        = var.resources["core"]["limits"]["memory"],
      core_request_cpu          = var.resources["core"]["requests"]["cpu"],
      core_limits_cpu           = var.resources["core"]["limits"]["cpu"],
      core_replicas             = var.replicas.core
    })
  ]
}

#
# Harbor HPA
#

data "template_file" "hpa_manifest_template" {
  
  template = file("${path.module}/hpa.yaml.tpl")
  vars     = {
    namespace_name                 = var.namespace_name,
    core_name_metadata             = "${helm_release.harbor.name}-core-hpa",
    core_name_deployment           = "${helm_release.harbor.name}-core",
    core_min_replicas              = var.hpa_core_config.min_replicas,
    core_max_replicas              = var.hpa_core_config.max_replicas,
    core_target_cpu_utilization    = var.hpa_core_config.target_cpu_utilization,
    core_target_memory_utilization = var.hpa_core_config.target_memory_utilization
  }
}

data "kubectl_file_documents" "hpa_manifest_files" {

  content = data.template_file.hpa_manifest_template.rendered
}

resource "kubectl_manifest" "apply_manifests" {
  for_each  = data.kubectl_file_documents.hpa_manifest_files.manifests
  yaml_body = each.value
}

#
# Walrus Information
#

locals {
  context          = var.context
  dash_domain_name = replace(var.domain_name, ".", "-")
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}