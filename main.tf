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

# HPA for Core Component
resource "kubernetes_horizontal_pod_autoscaler" "core" {
  metadata {
    name      = "${helm_release.harbor.name}-core-hpa"
    namespace = var.namespace_name
  }

  spec {
    scale_target_ref {
      kind       = "Deployment"
      name       = "${helm_release.harbor.name}-core"
      api_version = "apps/v1"
    }

    min_replicas = var.hpa_core_config.min_replicas
    max_replicas = var.hpa_core_config.max_replicas

    metric {
      type = "Resource"
      resource {
        name  = "cpu"
        target {
          type                = "Utilization"
          average_utilization = var.hpa_core_config.target_cpu_utilization
        }
      }
    }

    # metric {
    #   type = "Resource"
    #   resource {
    #     name  = "memory"
    #     target {
    #       type                = "Utilization"
    #       average_utilization = var.hpa_core_config.target_memory_utilization
    #     }
    #   }
    # }
  }
}

# HPA for Jobservice Component
# resource "kubernetes_horizontal_pod_autoscaler" "jobservice" {
#   metadata {
#     name      = "jobservice-hpa"
#     namespace = var.namespace_name
#   }

#   spec {
#     scale_target_ref {
#       kind       = "Deployment"
#       name       = "${helm_release.harbor.name}-jobservice"
#       api_version = "apps/v1"
#     }

#     min_replicas = 1
#     max_replicas = 5

#     metric {
#       type = "Resource"
#       resource {
#         name  = "memory"
#         target {
#           type               = "Utilization"
#           average_utilization = 70
#         }
#       }
#     }
#   }
# }

# # HPA for Portal Component
# resource "kubernetes_horizontal_pod_autoscaler" "portal" {
#   metadata {
#     name      = "portal-hpa"
#     namespace = var.namespace_name
#   }

#   spec {
#     scale_target_ref {
#       kind       = "Deployment"
#       name       = "${helm_release.harbor.name}-portal"
#       api_version = "apps/v1"
#     }

#     min_replicas = 2
#     max_replicas = 10

#     metric {
#       type = "Resource"
#       resource {
#         name  = "cpu"
#         target {
#           type               = "Utilization"
#           average_utilization = 75
#         }
#       }
#     }

#     metric {
#       type = "Resource"
#       resource {
#         name  = "memory"
#         target {
#           type               = "Utilization"
#           average_utilization = 80
#         }
#       }
#     }
#   }
# }

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