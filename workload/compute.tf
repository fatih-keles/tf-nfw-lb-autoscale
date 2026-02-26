resource "oci_core_instance_configuration" "app" {
  compartment_id = local.compartment_ocid
  display_name   = "${var.project_name}-app-ic"

  lifecycle {
    create_before_destroy = true
  }

  instance_details {
    instance_type = "compute"

    launch_details {
      compartment_id = local.compartment_ocid
      shape          = var.app_shape
      display_name   = "${var.project_name}-app"

      agent_config {
        are_all_plugins_disabled = false
        is_management_disabled   = false

        plugins_config {
          name          = "Management Agent"
          desired_state = "ENABLED"
        }

        plugins_config {
          name          = "Vulnerability Scanning"
          desired_state = "ENABLED"
        }

        plugins_config {
          name          = "Block Volume Management"
          desired_state = "ENABLED"
        }

        plugins_config {
          name          = "Bastion"
          desired_state = "ENABLED"
        }
      }

      shape_config {
        ocpus         = var.app_ocpus
        memory_in_gbs = var.app_memory_gbs
      }

      create_vnic_details {
        subnet_id              = local.app_private_subnet_id
        assign_public_ip       = false
        skip_source_dest_check = false
      }

      metadata = {
        ssh_authorized_keys = var.ssh_public_key
        user_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
          user_name        = var.user_name
          user_passwd_hash = var.user_passwd_hash
          fss_mount_ip     = local.fss_mount_ip
          fss_export_path  = local.fss_export_path
          fss_mount_path   = var.fss_mount_path
        }))
      }

      source_details {
        source_type = "image"
        image_id    = data.oci_core_images.ubuntu.images[0].id
      }
    }
  }
}

resource "oci_core_instance_pool" "app" {
  compartment_id            = local.compartment_ocid
  instance_configuration_id = oci_core_instance_configuration.app.id
  size                      = var.app_instance_count
  display_name              = "${var.project_name}-app-pool"

  placement_configurations {
    availability_domain = local.availability_domain
    primary_subnet_id   = local.app_private_subnet_id
    fault_domains       = [for fd in data.oci_identity_fault_domains.app.fault_domains : fd.name]
  }

  load_balancers {
    backend_set_name = oci_load_balancer_backend_set.app.name
    load_balancer_id = oci_load_balancer_load_balancer.app.id
    port             = 80
    vnic_selection   = "PrimaryVnic"
  }
}
