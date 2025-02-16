# Create Your Second Microservice with Node.js

- http://k8s.anjikeesari.com/microservices/2.node-api/

```bash
git clone bco@vs-ssh.visualstudio.com:v3/bco/node-api/node-api
cd node-api
npx express-generator --no-view src
cd src
npm install
DEBUG=src:* npm start
npm start
open http://localhost:3000/
```

- Dockerfile

```bash
docker search node
wget -q -O - "https://hub.docker.com/v2/namespaces/library/repositories/node/tags?page_size=100" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$' | grep alpine | grep 23
```

- build & run

```bash
cd ..
docker build -t sample/node-api:${TIMESTAMP}.1 . && docker run --rm -p 3000:3000 sample/node-api:$TIMESTAMP.1
open http://localhost:3000
```

- debug

```bash
sudo lsof -i -P | grep LISTEN | grep :3000
docker run --rm -it --entrypoint sh sample/node-api:$TIMESTAMP.1 # debug
```

- push

```bash
docker tag sample/node-api:$TIMESTAMP.1 $ACR_NAME.azurecr.io/sample/node-api:$TIMESTAMP.1
docker push $ACR_NAME.azurecr.io/sample/node-api:$TIMESTAMP.1
az acr repository list --name $ACR_NAME --output table
az acr repository show-tags --name $ACR_NAME --repository sample/node-api --output table
```

- git

```bash
git add .
git commit -am "${PWD:t} project - first commit"
git push
```
