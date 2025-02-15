# React JS application

- Create a new React JS application

```bash
echo y | npx create-react-app react-app
```

- x

```bash
cd react-app
npm start
```

- build & run

```bash
docker build -t sample/react-app:${TIMESTAMP}.1 . && docker run --rm -p 3000:3000 sample/react-app:$TIMESTAMP.1
open http://localhost:3000
```

- push

```bash
docker tag sample/react-app:$TIMESTAMP.1 $ACR_NAME.azurecr.io/sample/react-app:$TIMESTAMP.1
docker push $ACR_NAME.azurecr.io/sample/react-app:$TIMESTAMP.1
az acr repository list --name $ACR_NAME --output table
az acr repository show-tags --name $ACR_NAME --repository sample/react-app --output table
```

- git

```bash
git add .
git commit -am "${PWD:t} project - first commit"
git push
```
