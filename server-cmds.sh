#!/usr/bin/env bash

set -e

export IMAGE=$1
export ECR_USER=$2
export ECR_PASS=$3
export ECR_REPO=$4

echo $ECR_PASS | docker login -u $ECR_USER --password-stdin $ECR_REPO

docker-compose -f docker_compose.yml up --detach

echo "success"