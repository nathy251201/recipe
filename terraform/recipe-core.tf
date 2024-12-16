
resource "kubernetes_deployment_v1" "recipe-core" {
  depends_on = [time_sleep.wait_service_cleanup]
  metadata {
    name = "recipe-core-deployment"
  }

  spec {
    selector {
      match_labels = {
        app = "recipe-core"
      }
    }

    template {
      metadata {
        labels = {
          app = "recipe-core"
        }
      }

      spec {
        container {
          image = "chiavegatto/question-core:latest"
          name  = "recipe-core-container"

          port {
            container_port = 80
            name           = "recipe-core-svc"
          }
          env_from {
            secret_ref {
              name = kubernetes_secret.db_credentials.metadata[0].name
            }
          }
          security_context {
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false

            capabilities {
              add  = []
              drop = ["NET_RAW"]
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = "recipe-core-svc"

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }

        security_context {
          run_as_non_root = true

          seccomp_profile {
            type = "RuntimeDefault"
          }
        }

        # Toleration is currently required to prevent perpetual diff:
        # https://github.com/hashicorp/terraform-provider-kubernetes/pull/2380
        toleration {
          effect   = "NoSchedule"
          key      = "kubernetes.io/arch"
          operator = "Equal"
          value    = "amd64"
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "recipe-core" {
  metadata {
    name = "recipe-core-loadbalancer"
    annotations = {
      #   "networking.gke.io/load-balancer-type" = "Internal" # Remove to create an external loadbalancer
    }
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.recipe-core.spec[0].selector[0].match_labels.app
    }

    ip_family_policy = "RequireDualStack"

    port {
      port        = 80
      target_port = kubernetes_deployment_v1.recipe-core.spec[0].template[0].spec[0].container[0].port[0].name
    }

    type = "LoadBalancer"
  }

  depends_on = [time_sleep.wait_service_cleanup]
}
