-- Track when a word is completed by Player

local IsDead = Component.create("IsDead")

--[[ 

 type = type of Word (general, start, quit, bonus, edge, etc...)
 In case I want special "deaths" for different types

--]]

function IsDead:initialize(deathtype)
  
  self.deathtype = deathtype or 'general'

end