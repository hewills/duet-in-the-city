-- Display System - Display images (backgrounds, sprites, etc..)

local DisplaySystem = class("DisplaySystem", System)

-- Components
local position
local display

function DisplaySystem:draw()
  
  --cycle display images and position
	for index, entity in pairs(self.targets) do
    
    -- get data
    position = entity:get("Position")
    display = entity:get("Display")
    
    -- set color and draw
    love.graphics.setColor(display.color)
    love.graphics.draw(display.image,position.x,position.y)
   
	end
end


function DisplaySystem:requires()
	return {"Display", "Position"}
end

return DisplaySystem
