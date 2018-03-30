-- Handles PlayerInput events (keyboard and mouse)

local PlayerInputEvent = class("PlayerInputEvent", System)

-- Variables
local currentFlag = 0
local n = 0
local keyset = {}

-- UTF Keypress Event
function PlayerInputEvent:utfEvent(event)

      local wordx = 9999 --set default word far to the right      
      local random_num = love.math.random(1,7)
      
      --print(event.key)
      currentFlag = 0

      -- Check if IsCurrent is set on any word
      for index, entity in pairs(Engine:getEntitiesWithComponent("IsCurrent")) do
          currentFlag = 1
      end
      
      -- If a word is set as Current. Check if player is still typing it
      if currentFlag == 1 then
  
          -- Need to check for finishing a word
          for index, entity in pairs(Engine:getEntitiesWithComponent("IsCurrent")) do
         
            local word = entity:get("drawString")
            local charidx = entity:get("IsCurrent").charidx
        
            -- Set index on what the current letter is
            if event.key == string.sub(word.astring,charidx+1,charidx+1) then
                entity:set(IsCurrent(charidx+1))
              
                -- ** SEE "String System Current" for setting typed words as dead **
                -- ** SEE "KillSystem" for starting game from Intro **
              
                -- ## TODO: Make IsCurrent as higher Priority than IsDead, if possible, so last letter is seen as red
            else
              
              if random_num == 1 then
                sounds.piano_mess1:play()
              elseif random_num == 2 then
                sounds.piano_mess2:play()
              elseif random_num == 3 then
                sounds.piano_mess3:play()
              elseif random_num == 4 then
                sounds.piano_mess4:play()
              elseif random_num == 5 then
                sounds.piano_mess5:play()
              elseif random_num == 6 then
                sounds.piano_mess6:play()
              elseif random_num == 7 then
                sounds.piano_mess7:play()
              end
                
            end        
          end
      
      else
          -- find current word farthest to the left...
          for index, entity in pairs(Engine:getEntitiesWithComponent("drawString")) do

              local letter = string.sub(entity:get("drawString").astring,1,1)  --check first letter
        
              if event.key == letter then
                  --If multiple words, flag the one farthest to the left (x coordinate)
                  if entity:get("Position").x < wordx then
                      wordx = entity:get("Position").x
                  end
              end
          end
          -- ... and set isCurrent
          for index, entity in pairs(Engine:getEntitiesWithComponent("drawString")) do
            
            local letter = string.sub(entity:get("drawString").astring,1,1)  --check first letter
            
              if event.key == letter and entity:get("Position").x == wordx then
                entity:add(IsCurrent())              
              end
              
          end
      end
      
end

-- Mouse Press Event
function PlayerInputEvent:mousepressEvent(event)
  
  if event.button == 1 then      
       print("Mouse X:" .. event.mousex .. " Y: ".. event.mousey)
       --Engine:toggleSystem("DisplaySystem")
  end
  
end

-- Keypress Events
function PlayerInputEvent:keypressEvent(event)

  -- Game Options
  -- #TODO: Replace Msgbox with options screen
  
  if event.scancode == "escape" then

    local title = "Game Options"
    local message = "What do you want?"
    local buttons = {"Help","Quit","Nevermind"}

    local pressedbutton = love.window.showMessageBox(title,message,buttons)
  
    if pressedbutton == 3 then --OK
      -- do nothing
    elseif pressedbutton == 2 then  --Quit
    
      local pressagain = love.window.showMessageBox("Big Quitter","Are you Sure?",{"No","Yes"})
    
        if pressagain == 2 then
            love.event.quit(0)
        end
      
    elseif pressedbutton == 1 then --Help
      local press3 = love.window.showMessageBox("Help","I have no help to give.",{"Not Sorry","Sorry"})
    end
  
  -- Clear currently typed word
  elseif event.scancode == "backspace" then
    
    -- Remove IsCurrent component from string entity
    for index, entity in pairs(Engine:getEntitiesWithComponent("IsCurrent")) do
      entity:remove("IsCurrent") 
    end
    
    sounds.piano_mess5:play()
  
  end


end

------------- End of PlayerInputEvent -------------------------
return PlayerInputEvent
