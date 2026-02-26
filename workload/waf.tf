resource "oci_waf_web_app_firewall_policy" "lb" {
  compartment_id = local.compartment_ocid
  display_name   = "${var.project_name}-waf-policy"

  actions {
    name = "allow-country"
    type = "ALLOW"
  }

  actions {
    name = "deny-all"
    type = "RETURN_HTTP_RESPONSE"
    code = 403
  }

  request_access_control {
    default_action_name = "deny-all"

    rules {
      type               = "ACCESS_CONTROL"
      name               = "allow-country"
      action_name        = "allow-country"
      condition_language = "JMESPATH"
      condition          = "i_contains(['${var.waf_allowed_country_code}'], connection.source.geo.countryCode)"
    }
  }
}

resource "oci_waf_web_app_firewall" "lb" {
  compartment_id             = local.compartment_ocid
  display_name               = "${var.project_name}-waf"
  backend_type               = "LOAD_BALANCER"
  load_balancer_id           = oci_load_balancer_load_balancer.app.id
  web_app_firewall_policy_id = oci_waf_web_app_firewall_policy.lb.id
}
