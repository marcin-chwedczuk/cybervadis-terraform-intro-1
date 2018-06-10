# This is a comment

/* This is a multiline
 * comment
 */

provider "local" {}

# resource RESOURCE_TYPE TF_RESOURCE_NAME
resource "local_file" "hello_world" {
  content = "Hello, World!"

  # ${path.module} - directory containing this .tf file
  filename = "${path.module}/hello_world"
}
