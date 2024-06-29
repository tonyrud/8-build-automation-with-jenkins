# Java Maven App

Simple Java application for testing Docker deploys in various environments.

## Snippets

Create kubeconfig

```bash
aws eks update-kubeconfig --name <cluster-name>
```

Create private registry secret in Docker Hub

```bash
kubectl create secret docker-registry my-registry-key \
--docker-server=docker.io \
--docker-username="<user>" \
--docker-password="<pass>"
```

With AWS ECR

```bash
kubectl create secret docker-registry my-registry-key \
--docker-server=326347646211.dkr.ecr.us-east-2.amazonaws.com \
--docker-username="<user>" \
--docker-password="<pass>"
```
