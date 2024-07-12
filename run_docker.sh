#!/bin/bash

echo "Loading env variables from './.env.local'"
export DOCKER_COMPOSE_ENV_FILE=./.env.local

echo "killing old docker processes"
docker compose rm -fs

echo "building docker containers"
docker compose --env-file $DOCKER_COMPOSE_ENV_FILE up --build -d