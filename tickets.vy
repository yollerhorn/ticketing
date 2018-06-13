# The array of seating tiers.
rgtier: {
   szName: bytes[256], # Allows a 255-character ASCII name with a trailing zero to mark the end of the string.
   cSeats: int128,
   cSeatsSold: int128,
   price: int128
   }[3]                # CWT - '3' should be replaced at contract creation time.

balanceOf: public(wei_value[address])

@public
def __init__():
#  The following assignments would be filled in at contract creation time. CWT
   self.rgtier[0] = {szName: "Tier A", cSeats: 20, cSeatsSold: 0, price: 150 }
   self.rgtier[1] = {szName: "Tier B", cSeats: 80, cSeatsSold: 0, price: 100 }
   self.rgtier[2] = {szName: "Tier C", cSeats: 60, cSeatsSold: 0, price:  40 }

# countTiers returns the count of seating tiers that have been defined for this contract.
# "In web3, if you make a state-changing transaction, the API will return the transaction hash for that
# transaction instead of any return values." So we mark with @constant any time we want to actually return a
# value.
@public
@constant
def countTiers() -> int128:
   return 3     # CWT

@public
@constant
def getTierName(iTier: int128) -> bytes[256]:
   assert iTier >= 0
   assert iTier < 3       # CWT - contract write time change
   return self.rgtier[iTier].szName

# seatsAvail returns the count of available (unsold) seats in the tier identified by iTier.
@public
@constant
def seatsAvail(iTier: int128) -> int128:
   assert iTier >= 0
   assert iTier < 3       # CWT - contract write time change
   return self.rgtier[iTier].cSeats - self.rgtier[iTier].cSeatsSold

@public
@payable
def buy(iTier: int128, c: int128):
   assert iTier >= 0
   assert iTier < 3       # CWT - contract write time change
   assert c >= 0
   if self.seatsAvail(iTier) >= c:
      self.rgtier[iTier].cSeatsSold += c

@public
def kill():
   selfdestruct(msg.sender)
