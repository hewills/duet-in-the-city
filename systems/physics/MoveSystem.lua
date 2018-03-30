-- Move System - handles moving and bouncing words and killing words that reach the edge of screen
-- #TODO using tween to bounce words

local MoveSystem = class("MoveSystem", System)

-- Components

-- Variables

function MoveSystem:update(dt)
  
  --gets speed from class object Velocity and adds delta
	for index, entity in pairs(self.targets) do
    
   -- object.x = object.x + speed*dt  Using dt for constant speed no matter the system
    entity:get("Position").x = entity:get("Position").x - (entity:get("Velocity").speed * dt)
    
    -- If word reaches edge of screen, it gets killed
    if (entity:get("Position").x < 24) then 
      entity:add(IsDead('edge'))    
    end
      
  end

end


function MoveSystem:requires()
	return {"Velocity", "Position"}
end

return MoveSystem
