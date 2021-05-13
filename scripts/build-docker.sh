#!/bin/bash
dirname=$(dirname $BASH_SOURCE)
cd $dirname/..

echo -e "\nBuilding Harmony One localnet container for Ganache...\n"

docker build --pull -t harmonyone/localnet-ganache ./docker