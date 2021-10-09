# An actual working repo for harmony localnet
Since none of the fucking harmony localnet repos work out of the box without headaches, here is how I made mine work.

### Step fucking one - build docker image
\scripts\build-docker.sh

### Step 2 - run the image
In other repoos it is missing option "-k" (keeps the chain running after tests are done) and in general pointing to wrong files.
``` 
    docker run --name harmony-localnet-ganache --m -p 9500:9500 -p 9800:9800 -p 9801:9801 -p 9501:9501 harmonyone/localnet-ganache -k
```
### Step 3 - import test wallet private key (only necessary if you want to do step #4)
``` 
    docker exec -it harmony-localnet-ganache hmy keys import-private-key 1f84c95ac16e6a50f08d44c7bde7aff8742212fda6e4321fde48bf83bef266dc
``` 
### step 4 - Transfer funds to your personal address
``` 
docker exec -it harmony-localnet-ganache hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to ONEYOURADDRESS --to-shard 0 --amount 10
``` 

### step 5 - Deploying the smart-contract
**create new .env file with contents:**
```
LOCALNET_PRIVATE_KEY='1f84c95ac16e6a50f08d44c7bde7aff8742212fda6e4321fde48bf83bef266dc'
TESTNET_PRIVATE_KEY='ENTER_PRIVATE_KEY_HERE'
MAINNET_PRIVATE_KEY='ENTER_PRIVATE_KEY_HERE'
```
This is the private key for _one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3_ wallet address. With this setting, you will be deploying contracts from this address.
If you want to deploy contracts with your own wallet address, replace the private key.

### Other stuff
**View commands for hmy cli**
````
    docker exec -it harmony-localnet-ganache hmy cookbook
````

**Premade wallets, give currency**
````
    /scripts/give-one.sh
````

**Ganache**

You can check out my fork from Ganache as well. If you start this docker image, ganache will pick it up.
Works also in windows.
````access transformers
    https://github.com/mnukka/ganache
````

## Carbage info from forked Readme - maybe it's useful

```
cd dapp-quickstart
yarn install
```

```
truffle migrate --network localnet --reset
```

### step 6 - interact with the contract through truffle
````
  truffle console --network localnet
  let instance = await Counter.deployed()
  instance
````

**Interacting with contract at specific address**
```
let specificInstance = await Counter.at("0x1234...");
```

[Truffle interacting-with-your-contracts](https://www.trufflesuite.com/docs/truffle/getting-started/interacting-with-your-contracts)

### Troubleshooting Harmony localnet

Localnet runs as a docker container and you can see the logs using `docker logs --follow harmony-localnet-ganache` or enter into the container with `docker exec -it harmony-localnet-ganache bash`

## Deploying a sample dApp with truffle

The sample app provides a few smart-contract examples to start with created using [truffle](https://www.trufflesuite.com/docs/truffle/overview).

> NOTE: The dApp is already configured to use the account `one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3` for the deployment on the localnet. If you want to deploy on testnet and/or mainnet, or use another deployment account, you just need to set the corresponding private key in [dapp-example/.env](dapp-example/.env).

## Default settings

### Exposed ports by the localnet
| Shard | RPC | WS |
|-|-|-|
| 0 | localhost:9500 | localhost:9800 |
| 1 | localhost:9501 | localhost:9801 |
