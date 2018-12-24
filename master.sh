#!/bin/bash
# https://docs.docker.com/compose/extends/
# Share Compose configurations between files and projects
# docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

docker-compose -f docker-compose.yml up -d
docker-compose -f docker-compose.prom.yml up -d
docker-compose -f docker-compose-wazuh.yml up -d


# Once the installations are completed, Start the automation script here.
