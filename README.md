# Java Maven App

Simple Java application for testing Docker deploys in various environments.

## Snippets

Create kubeconfig

```bash
aws eks update-kubeconfig --name <cluster-name>
```

Create private registry secret

```bash
kubectl create secret docker-registry my-registry-key \
--docker-server=docker.io \
--docker-username="<user>" \
--docker-password="<pass>"
```
