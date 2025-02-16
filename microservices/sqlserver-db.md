# sqlserver-db.md

- build

```bash
docker build -t my-sqlserver-image .
```

- run

```bash
docker run -d --rm --name my-sqlserver-container -p 5432:5432 -e SA_PASSWORD=Strong@Passw0rd my-sqlserver-image
```
