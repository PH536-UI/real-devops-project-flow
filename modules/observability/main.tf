# environments/local/docker.tf

# Prometheus Container
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.image_id

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = "${path.module}/../../observability/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.infra_net.name
  }

  command = [
    "--config.file=/etc/prometheus/prometheus.yml",
    "--storage.tsdb.path=/prometheus",
    "--storage.tsdb.retention.time=15d",
    "--web.enable-lifecycle"
  ]

  depends_on = [docker_container.floci]
}

resource "docker_image" "prometheus" {
  name = "prometheus:latest"
}

# Grafana Container
resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.image_id

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "GF_SECURITY_ADMIN_USER=admin",
    "GF_SECURITY_ADMIN_PASSWORD=admin",
    "GF_USERS_ALLOW_SIGN_UP=false"
  ]

  volumes {
    host_path      = "${path.module}/../../observability/grafana/provisioning"
    container_path = "/etc/grafana/provisioning"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.infra_net.name
  }

  depends_on = [docker_container.prometheus]
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

# Floci Container
resource "docker_container" "floci" {
  name  = "floci-aws"
  image = docker_image.floci.image_id

  ports {
    internal = 4566
    external = 4566
  }

  env = [
    "FLOCI_DEFAULT_REGION=us-east-1",
    "FLOCI_DEFAULT_ACCOUNT_ID=000000000000",
    "FLOCI_STORAGE_MODE=hybrid",
    "FLOCI_SERVICES_LAMBDA_EPHEMERAL=true"
  ]

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only      = false
  }

  networks_advanced {
    name = docker_network.infra_net.name
  }
}

resource "docker_image" "floci" {
  name = "floci/floci:latest"
}

# Network compartilhada
resource "docker_network" "infra_net" {
  name   = "infra-net"
  driver = "bridge"
}
