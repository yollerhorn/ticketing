# ticketing
Smart contract event ticketing on the Ethereum network

## Geth Commands

### To start mining on a private blockchain
```
geth --identity nodeSOL --nodiscover --networkid 13 --port 30303 --maxpeers 10 --lightkdf --cache 16 --rpc --rpccorsdomain "*" --datadir "C:\Eth\data-private" --minerthreads 1 --mine
```
Note that the value of the `--datadir` parameter above is just an example. It should be replaced with the correct path on the local machine. 

### To start a Geth command prompt attached to the local Ethereum node
```
geth --datadir "C:\Eth\data-private" attach ipc:\\.\pipe\geth.ipc
```
As with the preceding command, the `--datadir` parameter must be correctly specified for the local machine.

### To deploy the contract
```
var bar = eth.contract( ABI (as a literal JavaScript array of objects) goes here)
var bytecode = "0x .... "
var deploy = {from: eth.coinbase, data: bytecode, gas: 2000000}
var barPartInst = bar.new(deploy)
```
You must now wait for the contract to be mined. You can keep checking `barPartInst.address` to know when mining is complete. When it is, `barPartInst.address` will have a valid Ethereum network address in it and you can use that value to get an actual contract instance pointer:
```
var barInst = bar.at(barPartInst.address)
```

### To call methods on the contract
Using the instance pointer you acquired above, you can now call methods. E.g.
```
barInst.seatsAvail(1)
```
Or, for a method that requires you to send wei, first set `eth.defaultAccount` like so:
```
eth.defaultAccount = eth.coinbase
```
(You only need to do this once in a given Geth session.)

Now you can call methods that send wei: 
```
barInst.buy(0, 1, {value: 150} )
```

### To kill the contract so that it is no longer active and cannot be called
```
barInst.kill()
```
Wait a few moments (for mining to occur), then verify that the contract has been removed by doing:
```
eth.getCode(barInst.address)
```
When the contract has been successfully removed, this will return an empty hex string.


### To unlock your account (which you need to do to deploy a contract or send ether)
```
personal.unlockAccount(eth.coinbase)
```
This will prompt you for your password. (Hopefully, you remember it.)
