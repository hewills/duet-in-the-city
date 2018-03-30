-- Subway Scene (Level 1)

local Subway = Classic:extend()

-- Create Entities
local screen = Entity()
--local guy = Entity()
local title = Entity()
local score = Entity()

-- Variables
local titleWidth = 0

-- Graphics
local frameWidth = 32
local frameHeight = 32
local scaled = 6
local num_players = 4

local player = {}
local curr_player

local img = love.graphics.newImage(gfx .. '/sprite/NewCareer/player_choice.png')
img:setFilter("nearest", "nearest")

  for x=1, num_players do  
     player[x] = love.graphics.newQuad(32*(x-1), 0, 32, 32, img:getDimensions())
  end

    
function Subway:enter()
  
  music.gamemusic5:play()
    
  local i = 0
  
  for index, entity in pairs(Engine:getEntitiesWithComponent("Game")) do
        curr_player = player[entity:get("Game").character]
  end  
  
  -- Screen width
  local width = love.graphics.getWidth( )

  --Add components to Entities
  screen:add(Display(gfx .. '/img/music_staff.png')) --Music Bars
  screen:add(Position(0,62))
  
  title:add(Word(pixel8_lrg,'Subway (Level 1)'))
  titleWidth = title:get("Word").width
  title:add(Position(math.floor((width-width/7)-(titleWidth/2)),25))
  
  score:add(Word(pixel8_lrg,'$'))
  score:add(Position(250,25))
   
  --guy:add(Display(gfx .. '/img/subway_guy.png')) --Guy
  --guy:add(Position(200,480))
  
  -- Add Entities to Engine
  Engine:addEntity(screen)
  Engine:addEntity(title)
  Engine:addEntity(score)
  --Engine:addEntity(guy)
  
end

-- ** UPDATE
function Subway:update(dt)
  
  local words_in_play = 0
  local maxnumber = 0
   
  words_in_play = Engine:getEntityCount("drawString")

  for index, entity in pairs(Engine:getEntitiesWithComponent("Game")) do
    maxnumber = entity:get("Game").numwords
  end  
  
  if words_in_play < maxnumber then
      Eventmanager:fireEvent(CreateWord(maxnumber - words_in_play))
  end

end

-- ** DRAW
function Subway:draw()
  
  love.graphics.push()  
  love.graphics.scale(scaled)

  love.graphics.draw(img,curr_player,50/scaled,500/scaled)
  
  love.graphics.pop() -- Return to original graphic state  

end

-- ** LEAVE
function Subway:leave()
  
  Engine:removeEntity(screen)
  Engine:removeEntity(title)
  Engine:removeEntity(score)
  --Engine:removeEntity(guy)
  
  music:stop()
  
end

return Subway
