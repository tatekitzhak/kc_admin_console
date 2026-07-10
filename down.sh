#!/bin/bash

cd "$(dirname "$0")"
docker compose down --remove-orphans
sudo docker system prune -f
