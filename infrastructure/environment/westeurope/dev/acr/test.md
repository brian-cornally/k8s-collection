# Validate ACR resource

```bash
ACR_NAME=bc$ACR_NAME
az acr login --name $ACR_NAME

docker images | grep sample/aspnet-api
docker tag sample/aspnet-api:20250214.1 $ACR_NAME.azurecr.io/sample/aspnet-api:20250214.1
docker push $ACR_NAME.azurecr.io/sample/aspnet-api:20250214.1
```

- Pull image from registry

```bash
docker pull $ACR_NAME.azurecr.io/sample/aspnet-api:20230226.1
```

- List container images

```bash
az acr login --name $ACR_NAME
az acr repository list --name $ACR_NAME
```
