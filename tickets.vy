showMeCalled: event()
balanceOf: public(wei_value[address])
seeWhatYouGot: bytes[80]
theAnswer: int128

@public
def __init__():
   self.seeWhatYouGot = "I want to see what you got!"
   self.theAnswer = 42

@public
@payable
def buy():
   assert msg.value > 0
   # We sell Tribillium at a rate of 1:1 to Ether
   self.balanceOf[msg.sender] += msg.value

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
def WhatsTheAnswer() -> int128:
   return self.theAnswer

@public
def kill():
   selfdestruct(msg.sender)
