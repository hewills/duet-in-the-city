-- Handles creating new words (by creating new Entities) for the Player

local WordCreatorEvent = class("WordCreatorEvent", System)

local i = 0
local word = {}

function WordCreatorEvent:createWord(event)
  
  -- Number of words needed and types
  local wordcount = event.total
  local wordtype = event.type
  
  local tablecount = tbl.size(wordtable)
  local randomnum = love.math.random(1,tablecount)
  
  -- Create entity for each word needed
  -- x: 1200 (edge of screen)  y: min: 82 max: 216
  for i=1, wordcount do
    
      tablecount = tbl.size(wordtable)
      randomnum = love.math.random(1,tablecount)
    
        word[i] = Entity()
        word[i]:add(drawString(pixel8,wordtable[randomnum]))
        word[i]:add(Position(love.math.random(1200,1400),love.math.random(82,216)))
        word[i]:add(Velocity(love.math.random(100,125),0))
        
        table.remove(wordtable,randomnum) -- don't use word again. remove from table
        
        Engine:addEntity(word[i])
  end

end -- end of main function

------------- End of WordCreatorSystem -------------------------
return WordCreatorEvent