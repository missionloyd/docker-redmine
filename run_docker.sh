#!/bin/bash

echo "killing old docker processes"
docker compose rm -fs

echo "setting development env variables in './.env.local'"
export DOCKER_COMPOSE_ENV_FILE=./.env.local

echo "building docker containers"
docker compose --env-file $DOCKER_COMPOSE_ENV_FILE up --build -d