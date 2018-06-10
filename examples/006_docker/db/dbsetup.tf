
# Setup Postgres database

provider "postgresql" {
  host            = "localhost"
  port            = "${var.db_port}"
  database        = "postgres"
  username        = "${var.db_user}"
  password        = "${var.db_pass}"
  sslmode         = "require"
  connect_timeout = 10
}

resource "postgresql_role" "db_app_login" {
  name     = "${var.app_db_user}"
  login    = true
  password = "${var.app_db_pass}"
}

resource "postgresql_database" "app_db" {
  name              = "app_db"
  owner             = "${var.app_db_user}"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}



