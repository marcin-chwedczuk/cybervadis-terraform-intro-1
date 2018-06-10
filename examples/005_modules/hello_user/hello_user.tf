variable "filename_prefix" {}

data "external" "current_user_name" {
  program = ["bash", "${path.module}/get_user_name.sh"]

  query = {}
}

resource "local_file" "hello_user" {
  content  = "Hi ${data.external.current_user_name.result.username}!"
  filename = "${var.filename_prefix}_${data.external.current_user_name.result.username}"

  provisioner "local-exec" {
    # Make file readonly
    command = "chmod a-wx ${local_file.hello_user.filename}"
  }
}

output "filename" {
  value = "${local_file.hello_user.filename}"
}
