#!/bin/bash
dirname=$(dirname $BASH_SOURCE)
cd $dirname/..

echo -e "\nBuilding Harmony One localnet container for Ganache...\n"

docker build --pull -f Dockerfile.ganache -t harmonyone/localnet-ganache ./docker

echo -e "\nBuilding Ganache with Harmony One support...\n"
cd ganache-harmony && npm install && npm run build-linux