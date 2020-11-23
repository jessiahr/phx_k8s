# PhxK8s

## How to run on k8s

https://itnext.io/elixir-plus-kubernetes-part-1-80129eab14f0

``` bash
DB_URL=ecto://postgres:postgres@localhost/phx_k8s_dev \
RELEASE_COOKIE=AbqvZMtgcN3eZfdfPgujTi21SPKzmBfuF9vlbajqX332arGsW4cUfYRLOaIsAUGbEgm \
SECRET_KEY_BASE=AbqvZMtgcN3eZPgujTi21SPKzmBfuF9vlbajqX332arGsW4cUfYRLOaIsAUGbEgm \
HOSTNAME=127.0.0.1 \
SERVICE_NAME=localhost.svc \
APP_HOST=localhost \
PORT=4000 \
_build/prod/rel/phx_k8s/bin/phx_k8s start

```


start a db 
```
docker run --rm -d \
  -h db \
  -e POSTGRES_DB=phx_k8s_prod \
  -p 5432 \
  --name db \
  --network phx-k8s-net \
  postgres:9.6
```



```
docker run -it -d --rm \
-e DB_URL=ecto://postgres:postgres@db/phx_k8s_prod \
-e RELEASE_COOKIE=secret-cookie \
-e SECRET_KEY_BASE=your-secret-key \
-e SERVICE_NAME=el-kube \
-e APP_HOST=localhost \
-e PORT=4000 \
--network el-kube-net --publish 4000:4000 phx_k8s:latest
```