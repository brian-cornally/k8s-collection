# Terraform Setup

creates

- ResourceGroup
- KeyVault
- StorageAccount
- ServicePrincipal
- Stores Credentials in KeyVault

# PowerShell Procedure

- see: [tf-mgmt.ps1](tf-mgmt.ps1)

# CLI procedure (Alternative)

```bash
AZ_CLIENT_NAME=sp-tfmgmt-dev
AZ_LOCATION=westeurope
AZ_RG_NAME=rg-tf-dev
AZ_KV_NAME=kv-tf-dev
AZ_SA_NAME=tfbco
AZ_SA_CONTAINER_NAME=state

AZ_TENANT_ID=$(az account show --query "tenantId" -o tsv) && echo AZ_TENANT_ID=$AZ_TENANT_ID
AZ_SUBSCRIPTION_ID=$(az account show --query id --output tsv) && echo AZ_SUBSCRIPTION_ID=$AZ_SUBSCRIPTION_ID
```

## create App & ServicePrincipal

```bash
az ad app create --display-name $CLIENT_NAME --sign-in-audience "AzureADMyOrg" --web-redirect-uris "http://localhost"
```

# create ServicePrincipal

```bash
AZ_OBJECT_ID=$(az ad sp show --id $AZ_CLIENT_ID --query id --output tsv) && echo AZ_OBJECT_ID=$AZ_OBJECT_ID
AZ_CLIENT_ID=$(az ad app list --display-name $CLIENT_NAME --query "[0].appId" -o tsv) && echo AZ_CLIENT_ID=$AZ_CLIENT_ID
az ad sp create --id $AZ_CLIENT_ID
AZ_CLIENT_SECRET=$(az ad app credential reset --id $AZ_CLIENT_ID --append --query password --output tsv) && echo AZ_CLIENT_SECRET=$AZ_CLIENT_SECRET
```

## Create new resource group

```bash

az group create -n $AZ_RG_NAME -l $AZ_LOCATION
```

## Storage Account & Container

```bash
az storage account create -n $AZ_SA_NAME -g $AZ_RG_NAME -l $AZ_LOCATION --sku "Standard_LRS"
AZ_SA_KEY=$(az storage account keys list -g $AZ_RG_NAME -n $AZ_SA_NAME --query '[0].value' -o tsv) && echo AZ_SA_KEY=$AZ_SA_KEY
az storage container create -n $AZ_SA_CONTAINER_NAME --account-name $AZ_SA_NAME --account-key $AZ_SA_KEY
```

# Create KeyVault

```bash
az keyvault create -n $AZ_KV_NAME -g $AZ_RG_NAME -l $AZ_LOCATION
```

## Assign Key Vault Administrator Role to Current User

```bash
AZ_USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)
az role assignment create --assignee $AZ_USER_OBJECT_ID \
    --role "Key Vault Administrator" \
    --scope /subscriptions/$AZ_SUBSCRIPTION_ID/resourceGroups/$AZ_RG_NAME/providers/Microsoft.KeyVault/vaults/$AZ_KV_NAME
```

## Verify Role Assignments

```bash
az role assignment list --assignee $AZ_USER_OBJECT_ID --all --query "[?roleDefinitionName=='Key Vault Administrator']" -o table
az role assignment list --assignee $AZ_CLIENT_ID --all --query "[?roleDefinitionName=='Key Vault Administrator']" -o table
```

## Set Values

```bash
az keyvault secret set --vault-name $AZ_KV_NAME --name "tf-subscription-id" --value $AZ_SUBSCRIPTION_ID
az keyvault secret set --vault-name $AZ_KV_NAME --name "tf-client-id" --value $AZ_CLIENT_ID
az keyvault secret set --vault-name $AZ_KV_NAME --name "tf-client-secret" --value $AZ_CLIENT_SECRET
az keyvault secret set --vault-name $AZ_KV_NAME --name "tf-tenant-id" --value $AZ_TENANT_ID
az keyvault secret set --vault-name $AZ_KV_NAME --name "tf-access-key" --value $AZ_SA_KEY
```

## Assign Key Vault Administrator Role to a Service Principal

```bash
az role assignment create --assignee $AZ_CLIENT_ID \
    --role "Key Vault Administrator" \
    --scope /subscriptions/$AZ_SUBSCRIPTION_ID/resourceGroups/$AZ_RG_NAME/providers/Microsoft.KeyVault/vaults/$AZ_KV_NAME
# az keyvault set-policy --name $AZ_KV_NAME --object-id $AZ_CLIENT_ID --secret-permissions get list --key-permissions get list - alternative if RBAC is not being used
```

# Configure Service Principal Role Assignment

```bash
az role assignment create --assignee-object-id $AZ_OBJECT_ID --role Owner --scope "/subscriptions/$AZ_SUBSCRIPTION_ID" --assignee-principal-type ServicePrincipal
```

# Commit

```bash
git add .
git commit -am "initial tf setup"
git push # --set-upstream origin develop
```

# References

- https://k8s.anjikeesari.com/azure/1-iac/
- https://k8s.anjikeesari.com/azure/1-microservices-architecture-on-aks/
- https://k8s.anjikeesari.com/azure/3-azure-account-subscription/
- https://k8s.anjikeesari.com/azure/6-tf-foundation-1/#introduction
- https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-microservices/aks-microservices
- https://learn.microsoft.com/en-us/azure/developer/terraform/create-resource-group?source=recommendations&tabs=azure-cli
- https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli
