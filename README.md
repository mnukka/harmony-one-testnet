# harmony-one-ganache-support
Integrates Ganache and Harmony in a seamless setup

## Prerequisites
* Docker 20.10+
* node 12+

## Setup
> Please NOTE that you will need to clone with `--recurisve` to get all the required dependencies

```
git clone --recursive https://github.com/GabrielNicolasAvellaneda/harmony-one-ganache-support
cd harmony-one-ganache-support
```

## This repository includes
* A link to a fork of Ganache with prebuilt Harmony blockchain support
* A document or setup guide on how to use Ganache for Harmony during the dApp development
* A sample repo with a working example of a simple dApp to use Ganache for Harmony
* A prebuilt Harmony blockchain image on Ganache
* A demo video posted to the public on how to use Ganache with Harmony localnet

## About the Ganache and Harmony integration
* Minimal requirements as it is implemented as a docker container
* Preloaded list of accounts 
* Display of Bech32 account format
* Full Ganache integration including:
    * A set a pre-configured accounts with 100 ONEs
    * Able to see the blocks that are mined
    * Able to see block details such as transactions
    * Accounts real-time balance updates
* Full Harmony One blockchian deployment
* hmy pre-configured with the 10 built-in accounts ready for testing.


This setup is ready to get you up and running with an environment for developing Harmony One dApps locally.

## Starting Gananche
* Build
* Run

```
docker build --pull -f Dockerfile.ganache -t harmonyone/localnet-ganache ./docker


docker run --name harmony-localnet-ganache --rm -it  -p 9500:9500 -p 9800:9800 -p 9801:9801 -p 9501:9501 harmonyone/localnet-ganache -k -n

docker rm -f ganache-harmony-localnet
```

## Deploying a sample dAppp with truffle



## How to setup a different private key for deploying a contract




