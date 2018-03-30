-- Game logic for tracking score, difficulty, options, etc...
local Game = Component.create("Game")

-- Image display components
function Game:initialize(name,score,difficulty,character,experience,wpm,level)
        
  -- Defaults
  self.name = name or "You"
  self.score = score or 0
  self.difficulty = difficulty or "STUDENT"
    
  if difficulty == "STUDENT" then self.numwords = 4
    elseif difficulty == "AMATUER" then self.numwords = 10
    elseif difficulty == "PROFESSIONAL" then self.numwords = 15
    elseif difficulty == "MAESTRO" then self.numwords = 25
    else self.numwords = 4
  end
  
  self.character = character or 1
  self.experience = experience or 0
  self.wpm = wpm or 0
  self.level = level or 1  

end