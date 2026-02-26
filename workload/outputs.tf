output "lb_public_ip" {
  value = data.terraform_remote_state.foundation.outputs.lb_public_ip
}

output "lb_public_ip_id" {
  value = data.terraform_remote_state.foundation.outputs.lb_public_ip_id
}
