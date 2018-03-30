-- Intro Scene (Menu)
local Intro = Classic:extend()

-- Variables
local max_words = 3
local titleWidth = 0
local wordWidth = 0
local i = 0

-- Entities
local title = Entity()
local word = {}

for i=1, max_words do
        word[i] = Entity()   
end

-- Graphics
local frameWidth = 64
local frameHeight = 64
local scaled = 4

-- *** Load Sprite animations *** ----------------------------
-- Piano (idle)
local duration = 0.8
local img = love.graphics.newImage(gfx .. '/sprite/Intro/piano/piano_intro.png')
img:setFilter("nearest", "nearest")
local grid = anim8.newGrid(frameWidth, frameHeight,img:getWidth(),img:getHeight())
local frames = grid('1-3',1)
local guy_idle = anim8.newAnimation(frames, duration)
--
-- *** End of Animation setup *** ---------------------------------
  
  
function Intro:enter()
    --[[  view Gamestate keys example
        for k,v in pairs(Gamestate.current()) do
             n=n+1
             keyset[n]=k
             print("Intro n: " .. n .. " k: " .. k)
        end
    --]]
  
  -- Screen width
  local width = love.graphics.getWidth( )
   
  title:add(Word(pixel8_lrg,'K  -  E  -  Y  - S'))
  titleWidth = title:get("Word").width
  title:add(Position(math.floor((width/2)-(titleWidth/2),2),50))

  word[1]:add(drawString(pixel8_lrg,'New Career'))
  wordWidth = word[1]:get("drawString").length
  word[1]:add(Position(math.floor((width/2)-(titleWidth/2)),600))
  
  word[2]:add(drawString(pixel8_lrg,'Load Career'))
  wordWidth = word[2]:get("drawString").length
  word[2]:add(Position(math.floor((width/2)-(titleWidth/2)),650))
  
  word[3]:add(drawString(pixel8_lrg,'Quit'))
  wordWidth = word[3]:get("drawString").length
  word[3]:add(Position(math.floor((width/2)-(titleWidth/2)),700))
  ---- finish adding Components

  Engine:addEntity(title)

  for i=1, max_words do
    Engine:addEntity(word[i])
  end

end

-- ** UPDATE
function Intro:update(dt)
    
    guy_idle:update(dt)

end

-- ** DRAW
function Intro:draw()

    love.graphics.scale(scaled)
    guy_idle:draw(img,370/scaled,280/scaled)

end

-- Remove entities when leaving level
function Intro:leave()

  -- Remove Entities
  Engine:removeEntity(title)

  for i=1, max_words do
    Engine:removeEntity(word[i])
  end
 
  --title = nil
  
  -- Clear Entities
  title:clearComponents()
  
  for i=1, max_words do
    --word[i] = nil
    word[i]:clearComponents()
  end

end

return Intro
