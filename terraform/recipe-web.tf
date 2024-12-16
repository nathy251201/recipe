
resource "kubernetes_deployment_v1" "recipe_web" {
  depends_on = [time_sleep.wait_service_cleanup]
  metadata {
    name = "recipe-web-deployment"
  }

  spec {
    selector {
      match_labels = {
        app = "recipe-web"
      }
    }

    template {
      metadata {
        labels = {
          app = "recipe-web"
        }
      }

      spec {
        container {
          image = "kamyokazem/recipe-web:latest"
          name  = "recipe-web-container"

          port {
            container_port = 80
            name           = "recipe-web-svc"
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
              port = "recipe-web-svc"

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

resource "kubernetes_service_v1" "recipe_web" {
  metadata {
    name = "recipe-web-loadbalancer"
    annotations = {
      #   "networking.gke.io/load-balancer-type" = "Internal" # Remove to create an external loadbalancer
    }
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.recipe_web.spec[0].selector[0].match_labels.app
    }

    ip_family_policy = "RequireDualStack"

    port {
      port        = 80
      target_port = kubernetes_deployment_v1.recipe_web.spec[0].template[0].spec[0].container[0].port[0].name
    }

    type = "LoadBalancer"
  }

  depends_on = [time_sleep.wait_service_cleanup]
}

