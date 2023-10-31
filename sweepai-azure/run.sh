#!/bin/bash

# Stop and remove all containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Pull sweepai docker image
docker pull sweepai/sweep:latest

# Run sweep
docker compose --file ./deep-foundation/docker-compose.yml up --detach webhook sandbox-web
docker compose --file ./linksplatform/docker-compose.yml up --detach webhook sandbox-web

# Remove redundant docker images
docker image prune --force
