# drupal

- https://k8s.anjikeesari.com/microservices/9.drupal/

- dc

```bash
docker-compose up -d
open http://localhost:8080
```

- psql

```bash
psql -d postgres -h localhost -U postgres
```

- docker

```bash
docker container ls
docker network ls

```

- build & run

```bash
docker build -t sample/aspnet-api:${TIMESTAMP}.1 .
docker run --rm -p 8080:8080 sample/aspnet-api:${TIMESTAMP}.1
```

- acr

```bash
az acr login --name ${ACR_NAME}
az acr list --resource-group rg-acr-dev --query "[].{acrLoginServer:loginServer}" --output table
```

- tag push

```bash
docker tag sample/aspnet-api:${TIMESTAMP}.1 ${ACR_NAME}.azurecr.io/sample/aspnet-api:${TIMESTAMP}.1
docker images
docker push ${ACR_NAME}.azurecr.io/sample/aspnet-api:${TIMESTAMP}.1
```

- show

```bash
az acr repository list --name ${ACR_NAME} --output table
az acr repository show-tags --name ${ACR_NAME} --repository sample/aspnet-api --output table
```

- commit

```bash
git add .
git commit -am "${PWD:t} project - first commit"
git push
```
