#!/bin/bash

echo "The current working directory: $PWD"
echo "The previous current working directory: $OPLDPWD"
_cwd="$PWD"

## use pwd command ##
_mydir="$(pwd)"

## or ##
_mydir="`pwd`"

echo "My working dir: $_mydir"

# https://docs.docker.com/compose/extends/
# Share Compose configurations between files and projects
# docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Postgres, Kong, Konga.
docker-compose -f $_mydir/docker-compose.yml up -d

#prometheus, nodeexporter, Grafana.
docker-compose -f $_mydir/docker-compose-prom.yml up -d

#ELK Stack
docker-compose -f $_mydir/docker-compose-wazuh.yml up -d

#portainer
docker-compose -f $_mydir/docker-compose-portainer.yml -d

#operational Dashboard.
docker-compose -f $_mydir/docker-compose-operation.yml -d





# Once the installations are completed, Start the automation script here.
