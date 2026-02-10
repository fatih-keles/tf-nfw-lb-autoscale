data "terraform_remote_state" "foundation" {
  backend = "oci"
  config = {
    bucket    = var.bucket
    namespace = var.namespace
    region    = var.region
    key       = "foundation/terraform.tfstate"
  }
}