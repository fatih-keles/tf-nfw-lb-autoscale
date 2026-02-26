# create a new repository on the command line
```bash
echo "# tf-nfw-lb-autoscale" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/fatih-keles/tf-nfw-lb-autoscale.git
git push -u origin main
```

# push an existing repository from the command line
```bash
git remote add origin https://github.com/fatih-keles/tf-nfw-lb-autoscale.git
git branch -M main
git push -u origin main
```

# sample .env file content
```bash
export TF_VAR_region="me-jeddah-1"
# demo compartment 
export TF_VAR_compartment_ocid="ocid1.compartment.oc1.."
export TF_VAR_project_name="poc-customer"
export TF_VAR_dns_label="customerpoc"
export TF_VAR_fss_export_path="/fss-export"
export TF_VAR_fss_mount_path="/mnt/fss"

export TF_VAR_user_name="fkeles"
export TF_VAR_ssh_public_key="$(cat ~/.ssh/app-server.key.pub)"
export TF_VAR_user_passwd_hash='pwd-hash'

export TF_VAR_bucket="tf-state-poc"
export TF_VAR_namespace="os-namespace"
```

# Terraform backend init (from .env) to save the state files in OCI Object Storage
```bash
source .env

terraform -chdir=foundation init \
	-backend-config="bucket=${TF_VAR_bucket}" \
	-backend-config="namespace=${TF_VAR_namespace}" \
	-backend-config="region=${TF_VAR_region}" \
	-backend-config="key=foundation/terraform.tfstate"

terraform -chdir=foundation plan

terraform -chdir=foundation apply
```

# Terraform backend init (from .env) to save the state files in OCI Object Storage
```bash
source .env

terraform -chdir=workload init \
	-backend-config="bucket=${TF_VAR_bucket}" \
	-backend-config="namespace=${TF_VAR_namespace}" \
	-backend-config="region=${TF_VAR_region}" \
	-backend-config="key=workload/terraform.tfstate"

terraform -chdir=workload plan

terraform -chdir=workload apply

```

<!-- psql -h 10.0.40.49 -p 5432 -U admin -d appdb

-p 5432 -U appuser -d appdb -->