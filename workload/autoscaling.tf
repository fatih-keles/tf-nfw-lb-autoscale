resource "oci_autoscaling_auto_scaling_configuration" "app" {
  compartment_id       = local.compartment_ocid
  display_name         = "${var.project_name}-app-autoscaling"
  cool_down_in_seconds = 300
  is_enabled           = true

  auto_scaling_resources {
    id   = oci_core_instance_pool.app.id
    type = "instancePool"
  }

  policies {
    display_name = "${var.project_name}-cpu-threshold"
    policy_type  = "threshold"

    capacity {
      initial = 2
      min     = 2
      max     = 10
    }

    rules {
      display_name = "${var.project_name}-scale-out"

      action {
        type  = "CHANGE_COUNT_BY"
        value = "2"
      }

      metric {
        metric_type = "CPU_UTILIZATION"

        threshold {
          operator = "GT"
          value    = 80
        }
      }
    }

    rules {
      display_name = "${var.project_name}-scale-in"

      action {
        type  = "CHANGE_COUNT_BY"
        value = "-2"
      }

      metric {
        metric_type = "CPU_UTILIZATION"

        threshold {
          operator = "LT"
          value    = 20
        }
      }
    }
  }
}
