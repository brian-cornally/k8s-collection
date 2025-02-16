# log-analytics-workspace

- azure

```bash
az login --use-device-code
az account list --output table
az account show --output table
```

- terraform init

```bash
terraform init
terraform init -reconfigure
```

- workspaces related

```bash
terraform workspace list
terraform workspace new dev
terraform workspace select dev
```

- terraform plan

```bash
terraform validate
terraform fmt
terraform plan -out=dev.tfplan -var-file="./environments/dev-variables.tfvars" && terraform apply dev.tfplan
terraform state list
```

- git

```bash
git add .
git commit -am "${PWD:t} project - first commit"
git push
```
