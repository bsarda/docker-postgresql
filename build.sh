#!/bin/sh
docker ps -a | grep bsarda/postgresql | awk '{print $1}' | xargs -n1 docker rm -f
docker rmi bsarda/postgresql
docker rmi bsarda/postgresql:9.5
docker build -t bsarda/postgresql:9.5 .
docker tag bsarda/postgresql:9.5 bsarda/postgresql:latest

