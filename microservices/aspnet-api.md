# Create Your First Microservice with .NET Core Web API

- http://k8s.anjikeesari.com/microservices/1.aspnet-api/
- https://learn.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-9.0&tabs=visual-studio
- https://towardsdev.com/swagger-ui-is-gone-in-net-9-heres-what-you-need-to-do-next-9a13e4fdcd4b

# aspnet-api

```bash
dotnet new list
dotnet new webapi -o aspnet-api --no-https -f net9.0
dotnet new webapi -o aspnet-api
cd aspnet-api
dotnet add package Microsoft.EntityFrameworkCore.InMemory
dotnet add package Swashbuckle.AspNetCore
alias dbr='dotnet build && dotnet run'
export ASPNETCORE_URLS=https://localhost:443
```

- add to Program.cs

```bash
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.Run();
```

- open

```bash
dotnet dev-certs https
dotnet dev-certs https --trust

open http://localhost:5182
open http://localhost:5182/swagger/index.html # Swagger URL
open http://localhost:5182/weatherforecast # API endpoint URL
open http://localhost:5182/api/aspnet-api/v1/weatherforecast # API endpoint URL
```

- commit

```bash
git add .
git commit -am "My fist commit - Create Web API project"
git push
```

- build

```bash
docker build -t sample/aspnet-api:${TIMESTAMP}.1 .
```

- run

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

-

```bash
az acr login --name acr1dev
```
