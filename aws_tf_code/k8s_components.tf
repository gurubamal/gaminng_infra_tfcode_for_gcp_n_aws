# Kubernetes Namespace
resource "kubernetes_namespace" "game_ns" {
  metadata {
    name = "game-platform"
  }
}

# Deploy Ingress Controller (e.g., NGINX Ingress)
resource "kubernetes_deployment" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-controller"
    namespace = kubernetes_namespace.game_ns.metadata[0].name
    labels = {
      app = "nginx-ingress"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx-ingress"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx-ingress"
        }
      }
      spec {
        container {
          name  = "nginx-ingress-controller"
          image = "k8s.gcr.io/ingress-nginx/controller:v0.41.2"
          args  = ["/nginx-ingress-controller"]
        }
      }
    }
  }
}

# Service for Ingress Controller
resource "kubernetes_service" "nginx_ingress_service" {
  metadata {
    name      = "nginx-ingress-service"
    namespace = kubernetes_namespace.game_ns.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx-ingress"
    }
    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
    }
  }
}
