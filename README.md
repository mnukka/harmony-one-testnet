#An actual working repo for harmony localnet
Since none of the fucking harmony localnet repos work out of the box without headaches, here is how I made mine work.

### Step fucking one - build docker image
\scripts\build-docker.sh

### Step 2 - run the image
In other repoos it is missing option "-k" (keeps the chain running after tests are done) and in general pointing to wrong files.
``` 
  docker run --name harmony-localnet-ganache --rm -p 9500:9500 -p 9800:9800 -p 9801:9801 -p 9501:9501 harmonyone/localnet-ganache -k
```
### Step 3 - import test wallet private key (only necessary if you want to do step #4)
``` 
exec -it harmony-localnet-ganache hmy keys import-private-key 1f84c95ac16e6a50f08d44c7bde7aff8742212fda6e4321fde48bf83bef266dc
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
This way you will be deploying contracts with the _one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3_ test wallet address

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

https://www.trufflesuite.com/docs/truffle/getting-started/interacting-with-your-contracts

### Troubleshooting Harmony localnet

Please notice that the localnet runs as a docker container and you can see the logs using `docker logs --follow harmony-localnet-ganache` or enter into the container with `docker exec -it harmony-localnet-ganache bash`

## Deploying a sample dApp with truffle

The sample app provides a few smart-contract examples to start with created using [truffle](https://www.trufflesuite.com/docs/truffle/overview).

> NOTE: The dApp is already configured to use the account `one1ax072u4nllu5z2f965dasqluwassy5kvjc36zr` for the deployment on the localnet. If you want to deploy on testnet and/or mainnet, or use another deployment account, you just need to set the corresponding private key in [dapp-example/.env](dapp-example/.env).


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

### Loading the dApp in Ganache

> 1. Click `Save` button to create a new workspace
![img-4](docs/ganache-harmony-4.jpg)

> 2. Navigate to `Contracts` section and click `Link Truffle Project`
![img-5](docs/ganache-harmony-5.jpg)

> 3. Click `Add Project` and browse for the truffle config file located at [dapp-quickstart/truffle-config.js](./dapp-quickstart/truffle-config.js)
![img-6](docs/ganache-harmony-6.jpg)

> 3. Click `Save and Restart`
![img-7](docs/ganache-harmony-7.jpg)

> 4. Navigate to `Contracts` section and see the deployed contracts and their related transactions.
![img-8](docs/ganache-harmony-8.jpg)


## Default settings

### Exposed ports by the localnet
| Shard | RPC | WS |
|-|-|-|
| 0 | localhost:9500 | localhost:9800 |
| 1 | localhost:9501 | localhost:9801 |

## Known Issues

Switching back and forth from ETH to Harmony sometimes creates a race condiction but overwall the Harmony integration works fine. I'm working on a fix for this.
