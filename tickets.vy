showMeCalled: event()

# The array of seating tiers.
rgtier: {
   wzName: bytes[256], # Allows a 127-character Unicode name with a trailing zero to mark the end of the string.
   cSeats: int128,
   cSeatsSold: int128,
   price: int128
   }[3]                # CWT - '3' should be replaced at contract creation time.

balanceOf: public(wei_value[address])
seeWhatYouGot: bytes[80]
cTktAvail: int128

@public
def __init__():
   self.seeWhatYouGot = "I want to see what you got!"
#   self.cTktAvail = 100
#  The following assignments would be filled in at contract creation time. CWT
   self.rgtier[0] = {wzName: "Tier A", cSeats: 20, cSeatsSold: 0, price: 150 }
   self.rgtier[1] = {wzName: "Tier B", cSeats: 80, cSeatsSold: 0, price: 100 }
   self.rgtier[2] = {wzName: "Tier C", cSeats: 60, cSeatsSold: 0, price:  40 }

# countAvail returns the count of available (unsold) seats in the tier identified by idTier.
@public
@constant
def countAvail(idTier: int128) -> int128:
   assert idTier >= 0
   assert idTier < 3       # CWT - contract write time change
#   return self.cTktAvail
   return self.rgtier[idTier].cSeats - self.rgtier[idTier].cSeatsSold

@public
@payable
def buy(idTier: int128, c: int128):
   assert idTier >= 0
   assert idTier < 3       # CWT - contract write time change
   assert c >= 0
   if self.countAvail(idTier) >= c:
      self.rgtier[idTier].cSeatsSold += c

# "In web3, if you make a state-changing transaction, the API will return the transaction hash for that
# transaction instead of any return values." So we mark with @constant any time we want to actually return a
# value.
@public
@constant
def showMe() -> bytes[80]:
   log.showMeCalled()
   return self.seeWhatYouGot 

@public
def kill():
   selfdestruct(msg.sender)
