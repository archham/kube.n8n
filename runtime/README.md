# Setup n8n on k3s

```
kubectl create namespace n8n-devel
kubectl config set-context --current --namespace=n8n-devel
```

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install n8n bitnami/postgresql \
  --namespace n8n-devel \
  --set auth.username=n8n \
  --set auth.database=n8n \
  --set primary.resources.requests.cpu=200m \
  --set primary.resources.requests.memory=256Mi \
  --set primary.resources.requests.ephemeral-storage=100Mi \
  --set primary.resources.limits.cpu=300m \
  --set primary.resources.limits.memory=384Mi \
  --set primary.resources.limits.ephemeral-storage=6Gi
```
```
kubectl create deployment redis --image=redis --port=6379
kubectl expose deployment redis --port=6379 --target-port=6379 --name=redis --type=ClusterIP

```

```
helm install n8n oci://8gears.container-registry.com/library/n8n --version n8n@1.106.3 -f values.yml

```

## Day2 Notes

### Export credentials from within container
* https://docs.n8n.io/hosting/cli-commands/#export-workflows-and-credentials
```
kubectl exec -it n8n-xxx -- /bin/sh
mkdir -p backup/{wf,cred}
n8n export:workflow --backup --output=./backup/wf/
n8n export:credentials --backup --output=./backup/cred/
```
```
```
```
```
