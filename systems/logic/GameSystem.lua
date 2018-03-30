-- Game System - Update game values and Show HUD

local GameSystem = class("GameSystem", System)

-- Components
local game

-- Variables


function GameSystem:draw()
  
local width = love.graphics.getWidth()
  
	for index, entity in pairs(self.targets) do
    
    -- get data
    game = entity:get("Game")
    
    -- set color and draw
    love.graphics.setColor({255, 0, 0 ,255})
    love.graphics.setFont(pixel8_lrg)
    love.graphics.print(tostring(game.score),280,26)
    
    love.graphics.setColor({245,158,72,255})
    love.graphics.print(tostring(game.name),100,775)
    
  end

end


function GameSystem:requires()
	return {"Game"}
end

return GameSystem
