-- String System - Handles words that the user will be typing

local StringSystem = class("StringSystem", System)

-- Components
local position
local drawString

-- Variables
local idx = 0

function StringSystem:draw()
  
  --cycle text and position
	for index, entity in pairs(self.targets) do
    
    -- get data
    position = entity:get("Position")
    drawString = entity:get("drawString")
        
    -- set Font and Color
    love.graphics.setFont(drawString.font)
    love.graphics.setColor(drawString.color)
    
      --Print each character in the word
      for idx = 1, drawString.length do
      
        love.graphics.print(string.sub(drawString.astring,1,i),position.x,position.y)
        
      end
 
  end

end


function StringSystem:requires()
	return {"drawString", "Position"}
end

return StringSystem
