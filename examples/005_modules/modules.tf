provider "local" {}

module "hello_current_user" {
  source          = "hello_user"
  filename_prefix = "hello"
}

module "witaj_current_user" {
  source          = "hello_user"
  filename_prefix = "witaj"
}

output "created_files" {
  value = ["${module.hello_current_user.filename}", "${module.witaj_current_user.filename}"]
}
