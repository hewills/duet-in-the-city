-- String System Current - Handles current word user is actively typing

local StringSystemCurrent = class("StringSystemCurrent", System)

-- Components
local position
local drawString
local iscurrent

-- Variables
local idx = 0

function StringSystemCurrent:draw()
  
  --cycle text and position
	for index, entity in pairs(self.targets) do
    
    -- get data
    position = entity:get("Position")
    drawString = entity:get("drawString")
    iscurrent = entity:get("IsCurrent")
    
    -- set Font and Color
    love.graphics.setFont(drawString.font)
    love.graphics.setColor(drawString.color)
    
      --Print each character in the word
      for idx = 1, drawString.length do
        
       love.graphics.setColor(iscurrent.color)
       love.graphics.print(string.sub(drawString.astring,1,iscurrent.charidx),position.x,position.y)
        
      end
      
      -- If last letter is typed, set word as destroyed
      if drawString.length == iscurrent.charidx then
            entity:add(IsDead())
      end
  
  end
end


function StringSystemCurrent:requires()
	return {"drawString", "Position", "IsCurrent"}
end

return StringSystemCurrent
