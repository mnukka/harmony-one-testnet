# harmony-one-ganache-support
Integrates Ganache and Harmony in a seamless setup

## Prerequisites
* Docker 20.10+
* node 12+
* yarn


## How this works

TODO


## Default Settings accounts

### Localnet configuration

Exposed ports
| Shard | RPC | WS |
|-|-|-|
| 0 localhost:9500 | localhost:9800 |
| 1 localhost:9501 | localhost:9801 |


### Test Accounts
| Account Bech32 | Address | Initial Funds | Private Key
|-|-|-|-|
| one1v92y4v2x4q27vzydf8zq62zu9g0jl6z0lx2c8q | one1v92y4v2x4q27vzydf8zq62zu9g0jl6z0lx2c8q | 100 ONE

## Setup
> Please NOTE that you will need to clone with `--recurisve` to get all the required dependencies

```
git clone --recursive https://github.com/GabrielNicolasAvellaneda/harmony-one-ganache-support
cd harmony-one-ganache-support
```

## Directory Layout
```
.
├── dapp-quickstart       # A simple Harmony One DApp already configured for localnet development for use with Ganache.
├── docker                # Docker container configuration and files for the Ganache Harmony One localnet with a set of already funded accounts for testing.
├── Dockerfile.ganache

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

## Deploying a sample DApp with truffle

> NOTE: The DApp is already configured to use the account `` for doing the deployment on the localnet. If you want to reuse this for testnet and mainnet you just need to set the corresponding private key in [dapp-quickstart/.env](dapp-quickstart/.env).

### Setup
```
cd dapp-quickstart
yarn install
```

### Deploying the smart-contract
```
truffle migrate --network localnet --reset
```

### Interacting with the smart contract

We are going to start the truffle console so we can interact with the smart-contract `Counter` in a repl environment.
```
truffle console --network localnet
```

We will first need and instance of the smart contract and later call the `incrementCounter` method to change the state, increasing the counter as expected.

```
truffle(localnet)> Counter.deployed().then(instance => { counter = instance } )
counter.incrementCounter().

> NOTE that when changing the state of a contract a transaction will be sent.

{
  tx: '0xb510348c0c8a3de2b72896633b447f388b3be004f9d07328314261a35a2ff3eb',
  receipt: {
    blockHash: '0xab5dc55f2f15fb1cc394358d6cd6a8943daa963fad49f77fcb891f47e90316a0',
    blockNumber: 95,
    contractAddress: null,
    cumulativeGasUsed: 42041,
    from: '0xe99fe572b3fff9412925d51bd803fc77610252cc',
    gasUsed: 42041,
    logs: [],
    logsBloom: '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
    status: true,
    to: '0xd7a480867d7cfb975f881357ffd6feb81f950e2e',
    transactionHash: '0xb510348c0c8a3de2b72896633b447f388b3be004f9d07328314261a35a2ff3eb',
    transactionIndex: 0,
    rawLogs: []
  },
  logs: []
}
```

We can now verify the new state by calling the `getCount` method.

```
truffle(localnet)> counter.getCount()
BN { negative: 0, words: [ 1, <1 empty item> ], length: 1, red: null }
```

### Loading the DApp in Ganache






## How to setup a different private key for deploying a contract




