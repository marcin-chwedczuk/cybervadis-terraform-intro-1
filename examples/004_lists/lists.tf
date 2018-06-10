variable "list_of_files" {
  description = "List of file names like [\"foo\",\"bar\"]."
  type        = "list"
}

provider "local" {}

resource "local_file" "hello_world" {
  count   = "${length(var.list_of_files)}"
  content = "Hello file ${element(var.list_of_files, count.index)}!"

  filename = "${path.module}/hello_world_${count.index}.txt"
}

output "list_of_created_files" {
  value = "${local_file.hello_world.*.filename}"
}
