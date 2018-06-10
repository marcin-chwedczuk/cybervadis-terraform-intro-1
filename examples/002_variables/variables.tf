variable "file_suffix" {
  description = "Suffix of the file with dot, e.g. `.txt`."

  # No extension by default
  default = ""

  # type - string by default, but can also be list or map
  type = "string"
}

provider "local" {}

# resource RESOURCE_TYPE TF_RESOURCE_NAME
resource "local_file" "hello_world" {
  content = "Hello, World!"

  # ${path.module} - directory containing this .tf file
  filename = "${path.module}/hello_world${var.file_suffix}"
}

output "create_file_name" {
  description = "Full path of the created file name."
  value       = "${local_file.hello_world.filename}"
}
