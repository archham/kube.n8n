# Setup n8n on k3s

```
kubectl create namespace __NAMESPACE__
kubectl config set-context --current --namespace=__NAMESPACE__
```

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install n8n bitnami/postgresql \
  --namespace __NAMESPACE__ \
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
helm install myn8n oci://8gears.container-registry.com/library/n8n --version __VERSION__ -f values.yml

```

## Day2 Notes

### Export credentials and workflows from within container
* https://docs.n8n.io/hosting/cli-commands/#export-workflows-and-credentials
```
kubectl exec -it n8n-xxx -- /bin/sh
mkdir -p backup/{wf,cred}

env | grep N8N_ENCRYPTION_KEY > backup/key.env # must be same as on restore host in order to decrypt creds
n8n export:workflow --backup --output=./backup/wf/
n8n export:credentials --backup --output=./backup/cred/
```
### Import credentials and workflows from within container
```
kubectl exec -it n8n-xxx -- /bin/sh
find backup/{wf,cred}
env | grep N8N_ENCRYPTION_KEY  # must be same as on backup host in order to decrypt creds
n8n import:workflow --separate --input=backup/wf
n8n import:credentials --separate --input=backup/cred

```
```
```
