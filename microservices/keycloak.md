# keycloak

- https://k8s.anjikeesari.com/microservices/8.keycloak/
- https://anjikeesari.com/articles/keycloak/
- https://hub.docker.com/r/keycloak/keycloak
- https://www.keycloak.org/documentation
- https://github.com/keycloak/keycloak
- https://stackoverflow.com/questions/tagged/keycloak

- dc

```bash
docker-compose up
docker-compose up -d
docker ps
docker image ls | grep keycloak
docker container ls | grep keycloak
docker network ls
open http://localhost:8080
```

- build & run

```bash
docker build -t sample/keycloak-app:${TIMESTAMP}.1 .
docker run --rm -p 8080:8080 -v ./realm.json:/opt/keycloak/data/import/realm.json sample/keycloak-app:${TIMESTAMP}.1 start-dev --import-realm
```

- acr

```bash
az acr login --name ${ACR_NAME}
az acr list --resource-group rg-acr-dev --query "[].{acrLoginServer:loginServer}" --output table
```

- tag push

```bash
docker tag sample/keycloak-app:${TIMESTAMP}.1 ${ACR_NAME}.azurecr.io/sample/keycloak-app:${TIMESTAMP}.1
docker images
docker push ${ACR_NAME}.azurecr.io/sample/keycloak-app:${TIMESTAMP}.1
```

- show

```bash
az acr repository list --name ${ACR_NAME} --output table
az acr repository show-tags --name ${ACR_NAME} --repository sample/keycloak-app --output table
```

- commit

```bash
git add .
git commit -am "${PWD:t} project - first commit"
git push
```
