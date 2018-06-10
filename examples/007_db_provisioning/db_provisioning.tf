# Variables values are inlined only to make this
# example easier to run. Do NOT do this 
# in production code.
variable "db_port" {
  default = "6001"
}

variable "db_user" {
  default = "dbroot"
}

variable "db_pass" {
  default = "dbpass"
}

variable "app_db_user" {
  default = "app"
}

variable "app_db_pass" {
  default = "app123"
}

provider "postgresql" {
  /*
   * Because of issue 
   * https://github.com/terraform-providers/terraform-provider-postgresql/issues/30 
   * currently doesnt work with Postgres 10+, 
   * please change Postgres version to 9 in docker example.
   */

  host            = "localhost"
  port            = "${var.db_port}"
  database        = "postgres"
  username        = "${var.db_user}"
  password        = "${var.db_pass}"
  sslmode         = "disable"        # Do not do this in PROD!
  connect_timeout = 10
}

resource "postgresql_role" "app_role" {
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

  # Explicit dependency on another resource
  depends_on = ["postgresql_role.app_role"]
}
