#!/usr/bin/env bash

export IMAGE=$1
docker-compose -f docker_compose.yml up --detach
echo "success"
