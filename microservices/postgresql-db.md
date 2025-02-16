# postgresql-db

- https://k8s.anjikeesari.com/microservices/7.postgresql-db/

```bash
docker build -t my-postgresql-image .
```

- run

```bash
docker run -d --rm --name my-postgresql-container -p 5432:5432 my-postgresql-image
```

- dc

```bash
docker-compose up -d
docker container ls
```

- psql

```
brew install libpq
psql -h localhost -U myuser -d mydatabase
```

- psql commands

```bash
CREATE DATABASE mydatabase2;
```

- acr

```bash
az acr login --name ${ACR_NAME}
az acr list --resource-group rg-acr-dev --query "[].{acrLoginServer:loginServer}" --output table
```

- tag push

```bash
docker tag my-postgresql-image ${ACR_NAME}.azurecr.io/sample/my-postgresql-image:v1
docker images
docker push ${ACR_NAME}.azurecr.io/sample/my-postgresql-image:v1
```

- show

```bash
az acr repository list --name ${ACR_NAME} --output table
az acr repository show-tags --name ${ACR_NAME} --repository sample/aspnet-api --output table
```

- commit

```bash
git add .
git commit -am "My fist commit - Create Web API project"
git push
```

- acr

```bash
az acr login --name ${ACR_NAME}
az acr list --resource-group rg-acr-dev --query "[].{acrLoginServer:loginServer}" --output table
```

- tag push

```bash
docker tag sample/my-postgresql-image:v1 ${ACR_NAME}.azurecr.io/sample/my-postgresql-image:v1
docker images
docker push ${ACR_NAME}.azurecr.io/sample/my-postgresql-image:v1
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
