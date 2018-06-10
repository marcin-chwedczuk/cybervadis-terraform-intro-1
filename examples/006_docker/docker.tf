# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Internal network

# Create a new docker network
resource "docker_network" "app_net" {
  name = "app_net"
}

# Container with Postgres
resource "docker_image" "postgres-image" {
  name = "postgres:9"
}

resource "docker_container" "db" {
  image = "${docker_image.postgres-image.name}"

  # name of the container
  name     = "db"
  hostname = "db"

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_pass}",
  ]

  ports {
    internal = 5432
    external = "${var.db_port}"
  }

  networks = ["${docker_network.app_net.name}"]
}

# Container with Postgres admin GUI
resource "docker_image" "postgres-admin-gui-image" {
  name = "fenglc/pgadmin4:2-python3.6-jessie"
}

resource "docker_container" "db-gui" {
  image = "${docker_image.postgres-admin-gui-image.name}"

  # name of the container
  name     = "db-gui"
  hostname = "dbgui"

  env = [
    "DEFAULT_USER=${var.db_gui_user}",
    "DEFAULT_PASSWORD=${var.db_gui_pass}",
  ]

  ports {
    internal = 5050
    external = "${var.db_gui_port}"
  }

  networks = ["${docker_network.app_net.name}"]
}
