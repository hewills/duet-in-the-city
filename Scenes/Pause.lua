-- Pause Scene
local Pause = Classic:extend()
  
function Pause:enter(from)
  self.from = from
end


function Pause:draw()

  local titleWidth = 0
  local titleHeigth = 0
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
    
  love.graphics.setColor(64,64,64,100)
  love.graphics.rectangle('fill', 0,0, width,height)
  love.graphics.setColor({204, 0, 0 ,200})
  love.graphics.setFont(pixel8_lrg)
  love.graphics.print("** GAME PAUSED **", math.floor((width/2)-140),math.floor((height/2)))

end

return Pause
