# Zero Trust Azure Terraform Deployment

Terraform code to deploy Zero Trust enforcement policies in Azure.

## 🔐 What It Does

- Denies Public IP creation via custom Azure Policy
- Assigns policy at resource group level
- Uses secure IaC practices

## 📦 Resources Created

- Virtual Network & Subnets
- Network Interface
- Custom Azure Policy Definition
- Policy Assignment (RG-scoped)

## 🚀 Usage

```bash
terraform init
terraform plan
terraform apply
