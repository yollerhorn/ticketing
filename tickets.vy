g_cTier: uint256  # Count of tiers. Ideally this would be defined as a constant. But Vyper doesn't have constants.

# The array of seating tiers.
rgtier: {
   szName: bytes[256], # Allows a 255-character ASCII name with a trailing zero to mark the end of the string.
   cSeats: uint256,
   cSeatsSold: uint256,
   price: wei_value
   }[uint256]

balanceOf: public(wei_value[address])

@public
def __init__():
#  The following assignments would be filled in at contract creation time. CWT
   self.g_cTier = 3
   self.rgtier[0] = {szName: "Tier A", cSeats: 20, cSeatsSold: 0, price: 150 }
   self.rgtier[1] = {szName: "Tier B", cSeats: 80, cSeatsSold: 0, price: 100 }
   self.rgtier[2] = {szName: "Tier C", cSeats: 60, cSeatsSold: 0, price:  40 }

# countTiers returns the count of seating tiers that have been defined for this contract.
# "In web3, if you make a state-changing transaction, the API will return the transaction hash for that
# transaction instead of any return values." So we mark with @constant any time we want to actually return a
# value.
@public
@constant
def countTiers() -> uint256:
   return self.g_cTier

@public
@constant
def getTierName(iTier: uint256) -> bytes[256]:
   assert iTier < self.g_cTier
   return self.rgtier[iTier].szName

# seatsAvail returns the count of available (unsold) seats in the tier identified by iTier.
@public
@constant
def seatsAvail(iTier: uint256) -> uint256:
   assert iTier < self.g_cTier
   return self.rgtier[iTier].cSeats - self.rgtier[iTier].cSeatsSold

@public
@payable
def buy(iTier: uint256, c: uint256):
   assert iTier < self.g_cTier
   costOfPurchase: wei_value = c*self.rgtier[iTier].price
   assert msg.value >= costOfPurchase
   if self.seatsAvail(iTier) >= c:
      self.rgtier[iTier].cSeatsSold += c
      # send costOfPurchase to the theater
      if msg.value > costOfPurchase:
         send(msg.sender, msg.value - costOfPurchase) # send purchaser their change

@public
def kill():
   selfdestruct(msg.sender)
