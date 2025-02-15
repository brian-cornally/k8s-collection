# Create Your First Website using .NET Core MVC Application

- http://k8s.anjikeesari.com/microservices/3.aspnet-app/

-

```bash
dotnet new --list
dotnet new mvc -o aspnet-app
cd aspnet-app
```

- build & run

```bash
alias br='dotnet build && dotnet run'
br
```

- commit

```bash
git add .
git commit -am "My fist commit - Create Web API project"
git push
```

- build

```bash
docker build -t sample/aspnet-app:${TIMESTAMP}.1 .
```

- run

```bash
docker build -t sample/aspnet-app:${TIMESTAMP}.1 .
docker run --rm -p 8080:8080 sample/aspnet-app:${TIMESTAMP}.1
```

- acr

```bash

az acr login --name ${ACR_NAME}
az acr list --resource-group ${RG_NAME} --query "[].{acrLoginServer:loginServer}" --output table
```

- tag push

```bash
docker tag sample/aspnet-app:${TIMESTAMP}.1 ${ACR_NAME}.azurecr.io/sample/aspnet-app:${TIMESTAMP}.1
docker images
docker push ${ACR_NAME}.azurecr.io/sample/aspnet-app:${TIMESTAMP}.1
```

- show acr

```bash
az acr repository list --name ${ACR_NAME} --output table
az acr repository show-tags --name ${ACR_NAME} --repository sample/aspnet-app --output table
```
