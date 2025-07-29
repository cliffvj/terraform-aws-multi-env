# AWS Terraform Infrastructure (Multi-Environment)

## Project Structure
- **bootstrap/** – Creates the S3 bucket and DynamoDB table for remote Terraform state.
- **modules/** – Reusable modules (network, compute).
- **environments/** – Environment-specific configurations (dev, staging, prod).

---

## Steps to Use

### 1. Bootstrap Remote State
Before using Terraform in `environments/`, create the backend infrastructure (S3 bucket + DynamoDB table):

```bash
cd bootstrap
terraform init
terraform apply -var="bucket_name=terraform-999-state"   -var="dynamodb_table_name=terraform-locks"   
-var="aws_region=us-east-1"
```

This will output the bucket and table names to be used in your `backend.tf` files.

---

### 2. Initialize an Environment
For example, to deploy the **dev** environment:
```bash
cd ../environments/dev
terraform init
terraform plan
terraform apply
```

---

### 3. Promote to Staging/Prod
Edit variables in `staging/terraform.tfvars` or `prod/terraform.tfvars` and repeat the same steps.
```bash
cd ../environments/dev
terraform init
terraform plan
terraform apply
```
---

## SSH Access Control (`ssh_allowed_cidr`)

By default, the security group only allows SSH (port 22) from **your public IP**.
This is determined dynamically using:
```hcl
local.my_ip_cidr = "${chomp(data.http.my_ip.response_body)}/32"
```

### **Override for Open SSH Access**

If you need to allow SSH from anywhere (e.g., for testing), set in `terraform.tfvars`:
```hcl
ssh_allowed_cidr = "0.0.0.0/0"
```
### **How Precedence Works**
- If `ssh_allowed_cidr` is set in `terraform.tfvars`, that value overrides your IP.

- If left empty, it defaults to your public IP (`local.my_ip_cidr`).

- No CLI variable (`-var`) is needed unless you want a one-time override:
```bash
terraform apply -var="ssh_allowed_cidr=0.0.0.0/0"
```

---

## Notes
- S3 bucket and DynamoDB must exist **before** running `terraform init` in environments.
- State locking prevents concurrent Terraform runs that could corrupt state.
- Use different AWS profiles for each environment (dev, staging, prod) as needed.
- The `ssh_allowed_cidr` variable is designed to default to your IP for safety and can be overridden when required.