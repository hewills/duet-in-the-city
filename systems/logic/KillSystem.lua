-- Kill System - Handles words that are destroyed (aka typed completely)

local KillSystem = class("KillSystem", System)

-- Components
local position
local word
local isdead
local drawString

-- Variables
local idx = 0
local score = 0

function KillSystem:draw()

	for index, entity in pairs(self.targets) do
    
    -- get data
    position = entity:get("Position")
    word = entity:get("drawString")
    isdead = entity:get("IsDead")
    
    for index, entity in pairs(Engine:getEntitiesWithComponent("Game")) do
        score = entity:get("Game").score
    end        
    
    -- Type of word changes explosion
    if (isdead.deathtype == "general") then
      -- show circle when it dies (eventually add particle logic)
      love.graphics.setColor({255, 0, 0 ,255})
      love.graphics.circle("fill",position.x,position.y,100)
      score = score + word.points
    
    elseif (isdead.deathtype == "edge") then
      -- Bonus word
      love.graphics.setColor({140,0,0,255})
      love.graphics.circle("fill",position.x,position.y,150)
      score = score - word.points
      
    elseif (isdead.deathtype == "type") then
      -- Word reaches edge of screen before being typed
      love.graphics.setColor({255,255,0,255})
      love.graphics.circle("fill",position.x,position.y,50)
      score = score + word.points
    end
    
    --[[if (word.type == "general") then
      score = score + word.points
    
    elseif (word.type == "bonus") then
      score = score + word.points
      
    elseif (word.type == "special") then
      score = score + word.points
    end
    ]]--
  
    for index, entity in pairs(Engine:getEntitiesWithComponent("Game")) do
        entity:get("Game").score = score
    end    
        
    -- Killing intro words change gamestates
    if Gamestate.current() == intro then
    
        if word.astring == "Quit" then
            love.event.quit(0)
        end
        
        if word.astring == "New Career" then
            Gamestate.switch(newcareer) -- Start Career screen
        end
        
        if word.astring == "Load Career" then
            Gamestate.switch(loadcareer)
        end
        
    else
    
    -- don't bother removing entity for "intro" entities. Intro is a special case
    Engine:removeEntity(entity)
    
    end
  
  end

end


function KillSystem:requires()
	return {"drawString", "Position", "IsDead"}
end

return KillSystem
