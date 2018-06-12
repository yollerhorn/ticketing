showMeCalled: event()
balanceOf: public(wei_value[address])
seeWhatYouGot: bytes[80]
cTktAvail: int128

@public
def __init__():
   self.seeWhatYouGot = "I want to see what you got!"
   self.cTktAvail = 100

@public
def buy(c: int128):
   assert c >= 0
   if self.cTktAvail >= c:
      self.cTktAvail -= c

# "In web3, if you make a state-changing transaction, the API will return the transaction hash for that
# transaction instead of any return values." So we mark with @constant any time we want to actually return a
# value.
@public
@constant
def showMe() -> bytes[80]:
   log.showMeCalled()
   return self.seeWhatYouGot 

@public
@constant
def countAvail() -> int128:
   return self.cTktAvail

@public
def kill():
   selfdestruct(msg.sender)
