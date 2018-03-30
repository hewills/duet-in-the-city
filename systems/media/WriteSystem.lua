-- Write System - Handles "whole" words for display

local WriteSystem = class("WriteSystem", System)

-- Components
local position
local word

function WriteSystem:draw()
  --cycle word and position
	for index, entity in pairs(self.targets) do
    
    position = entity:get("Position")
    word = entity:get("Word")
    
    love.graphics.setColor(word.color)    
    love.graphics.draw(word.text,position.x,position.y)
    
	end
end


function WriteSystem:requires()
	return {"Word", "Position"}
end

return WriteSystem
