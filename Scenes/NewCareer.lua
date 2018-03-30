-- NewCareer Scene (Menu)
local NewCareer = Classic:extend()

-- Variables
local words = {}
local titleWidth = 0
local name = "_"
local x = 0
local i = 1
local num_players = 4
local num_player = 1
local max_words = 8

-- Entities
for i=1, max_words do
    words[i] = Entity()   
end

local game = Entity()

-- Graphics
local frameWidth = 32
local frameHeight = 32
local scaled = 6
local player = {}
local player_select = {}
local curr_player = {}
local player_img = {}
local num_setting = 1

-- *** Load Sprites *** ----------------------------
-- Create key images
local key_up = love.graphics.newImage(gfx .. '/sprite/NewCareer/key_up.png')
local key_down = love.graphics.newImage(gfx .. '/sprite/NewCareer/key_down.png')
local key_left = love.graphics.newImage(gfx .. '/sprite/NewCareer/key_left.png')
local key_right = love.graphics.newImage(gfx .. '/sprite/NewCareer/key_right.png')

-- Set Graphics to "nearest neighbor" for sizing
key_up:setFilter("nearest", "nearest")
key_down:setFilter("nearest", "nearest")
key_left:setFilter("nearest", "nearest")
key_right:setFilter("nearest", "nearest")

-- Create Sprite map image
local img = love.graphics.newImage(gfx .. '/sprite/NewCareer/player_choice.png')
local img2 = love.graphics.newImage(gfx .. '/sprite/NewCareer/player_choice_select.png')

img:setFilter("nearest", "nearest")
img2:setFilter("nearest", "nearest")

  for x=1, num_players do
  
     player[x] = love.graphics.newQuad(32*(x-1), 0, 32, 32, img:getDimensions())
     curr_player[x] = love.graphics.newQuad(32*(x-1), 0, 32, 32, img:getDimensions())
     player_select[x] = love.graphics.newQuad(32*(x-1), 0, 32, 32, img2:getDimensions())
     player_img[x] = img     
     
  end
  
curr_player[num_player] = player_select[num_player]
player_img[num_player] = img2
----
-- *** End of Sprites setup *** ---------------------------------

  
function NewCareer:enter()
  
  -- Screen width
  local width = love.graphics.getWidth( )  

  words[1]:add(Word(pixel8_lrg,'NEW CAREER'))
  titleWidth = words[1]:get("Word").width
  words[1]:add(Position(math.floor((width/2)-(titleWidth/2),2),50))
  
  words[2]:add(Word(pixel8_lrg,'What is your name'))
  titleWidth = words[2]:get("Word").width
  words[2]:add(Position(math.floor((width/2)-(titleWidth/2),2),100))
  
  words[3]:add(Word(pixel8_lrg,'Choose your Player'))
  titleWidth = words[3]:get("Word").width
  words[3]:add(Position(math.floor((width/2)-(titleWidth/2),2),200))
  
  words[4]:add(Word(pixel8_lrg,'Choose Difficulty Setting'))
  titleWidth = words[4]:get("Word").width
  words[4]:add(Position(math.floor((width/2)-(titleWidth/2),2),500))
  
  words[5]:add(Word(pixel8_lrg,'STUDENT'))
  titleWidth = words[5]:get("Word").width
  words[5]:add(Position(math.floor((width/2)-(titleWidth/2),2),550))
  
  words[6]:add(Word(pixel8_lrg,'AMATUER'))
  titleWidth = words[6]:get("Word").width
  words[6]:add(Position(math.floor((width/2)-(titleWidth/2),2),600))
  
  words[7]:add(Word(pixel8_lrg,'PROFESSIONAL'))
  titleWidth = words[7]:get("Word").width
  words[7]:add(Position(math.floor((width/2)-(titleWidth/2),2),650))
  
  words[8]:add(Word(pixel8_lrg,'MAESTRO'))
  titleWidth = words[8]:get("Word").width
  words[8]:add(Position(math.floor((width/2)-(titleWidth/2),2),700))
  ---- finish adding Components
    
  for i=1, max_words do
    Engine:addEntity(words[i])
  end
  
end

-- ** UPDATE
function NewCareer:update(dt)
  
end

-- ** DRAW
function NewCareer:draw()
  
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  local y = 300
  
  love.graphics.push()
  
  -- Draw Player character choices
  love.graphics.scale(scaled)
  

  
  for x=1, num_players do
     love.graphics.draw(player_img[x], curr_player[x], y/scaled, 220/scaled)
     y = y + 100
  end
  -- End drawing player choices  
 
   love.graphics.pop() -- Return to original graphic state  
  
  -- Draw left/right arrows
  local scalekeys = scaled - 3.5
  love.graphics.push()
  love.graphics.scale(scalekeys)

  titleWidth = words[3]:get("Word").width
  love.graphics.draw(key_left,math.floor((width/2)-(titleWidth/2)+345,2)/scalekeys,190/scalekeys)
  love.graphics.draw(key_right,math.floor((width/2)-(titleWidth/2)+400,2)/scalekeys,190/scalekeys)
  -- end draw arrows
  
  -- Draw up/down arrows
  titleWidth = words[4]:get("Word").width
  love.graphics.draw(key_up,math.floor((width/2)-(titleWidth/2)+445,2)/scalekeys,490/scalekeys)
  love.graphics.draw(key_down,math.floor((width/2)-(titleWidth/2)+445,2)/scalekeys,545/scalekeys)
  -- end draw arrows
  
  love.graphics.pop() -- Return to original graphic state
   
  local length = #name
   
  -- Draw Person's name
  love.graphics.setColor({204, 0, 0 ,200})
  love.graphics.setFont(pixel8_lrg)
  love.graphics.print(name,(math.floor((width/2)-(100/4),2)),150)  
  ----------------------
  
  -- Set colors of Difficulty settings to show current one
  for i=5, max_words do
     words[i]:get("Word").color = {255, 255, 255 ,255}
  end
  
  words[num_setting+4]:get("Word").color = {255,0,0,255} 
  


end

-- KeyPress: Capture player name by creating Word
function NewCareer:textinput(key)

   if name == "_" then name = "" end
   
   --Add characters to name up to 15
   if #name < 15 then name = name .. key end
   
end

function NewCareer:keypressed(key,scancode,isrepeat)
  
  if key == "backspace" then
     name = string.sub(name, 1, #name-1)
  end
  
  -- Cycle player choice to the left
  if key == "left" then
    
    if num_player > 1 then
      
      curr_player[num_player] = player[num_player]
      player_img[num_player] = img
      
      num_player = num_player - 1
      
      player[num_player] = player_select[num_player]
      player_img[num_player] = img2
    
    end
  end
  
  -- Cycle player choice to the right
   if key == "right" then
    
    if num_player < 4 then
      
      curr_player[num_player] = player[num_player]
      player_img[num_player] = img
      
      num_player = num_player + 1

      curr_player[num_player] = player_select[num_player]
      player_img[num_player] = img2
      
    end
  end
  
  -- Cycle difficulty settings up/down
  if key == "down" then

    if num_setting < 4 then
      num_setting = num_setting + 1
    else
      num_setting = 1
    end
    
  end
  
   if key == "up" then

    if num_setting > 1 then
      num_setting = num_setting - 1
    else
      num_setting = 4
    end
    
  end
  
  -- Start Game
  if key == "return" then
    
    --[[ 
          num_player:   Character selected by player
          num_setting:  Difficulty setting selected by player
          name:         Player name          
    --]]
    
    -- Create and Set Game global values
    game:add(Game(name,0,num_setting,num_player,0,0,1))
    Engine:addEntity(game)
    
    Gamestate.switch(subway)
    
  end
  
  
end

-- ** LEAVE Gamestate
function NewCareer:leave()

  -- Remove Entities
  for i=1, max_words do
    Engine:removeEntity(words[i])
  end
  
  -- Clear Entities
  for i=1, max_words do
    words[i]:clearComponents()
  end

end

return NewCareer