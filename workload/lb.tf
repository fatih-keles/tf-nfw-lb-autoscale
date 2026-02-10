resource "oci_load_balancer_load_balancer" "app" {
  compartment_id = local.compartment_ocid
  display_name   = "${var.project_name}-lb"
  shape          = "flexible"
  subnet_ids     = [local.lb_public_subnet_id]
  is_private     = false
  reserved_ips {
    id = local.lb_public_ip_id
  }
  network_security_group_ids = [local.nsg_lb_id]

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 100
  }
}

resource "oci_load_balancer_backend_set" "app" {
  load_balancer_id = oci_load_balancer_load_balancer.app.id
  name             = "${var.project_name}-app-bes"
  policy           = "ROUND_ROBIN"

  health_checker {
    protocol         = "HTTP"
    port             = 80
    url_path         = "/"
    return_code      = 200
    interval_ms       = 10000
    timeout_in_millis = 3000
    retries          = 3
  }
}

resource "oci_load_balancer_listener" "http" {
  load_balancer_id         = oci_load_balancer_load_balancer.app.id
  name                     = "${var.project_name}-http"
  default_backend_set_name = oci_load_balancer_backend_set.app.name
  port                     = 80
  protocol                 = "HTTP"
}
