# ticketing
Smart contract event ticketing on the Ethereum network

## Geth Commands

### To deploy the contract
```
var bar = eth.contract( ABI (as a literal JavaScript array of objects) goes here)
var bytecode = "0x .... "
var deploy = {from: eth.coinbase, data: bytecode, gas: 2000000}
var barPartInst = bar.new(deploy)
```
You must now wait for the contract to be mined. You can keep checking `barPartInst.address` to know when mining of the contract is complete. When it is, `barPartInst.address` will have a valid Ethereum network address in it.

Now you can get an actual contract instance pointer:
```
var barInst = bar.at(barPartInst.address)
```

### To call methods on the contract
Using the instance pointer you acquired above, you can now call methods. E.g.
```
barInst.seatsAvail(1)
```
Or, for a method that requires you to send wei:
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
