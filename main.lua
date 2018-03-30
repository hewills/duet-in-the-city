-- Directory Paths
events = 'events'
gfx = 'gfx'
lib = 'lib'
obj = 'obj'
comp = 'components'
sys = 'systems'
scenes = 'Scenes'
data = 'data'
audio = 'audio'

-- Third-party Libraries -----------------------
Gamestate = require (lib .. ".hump.gamestate")        --gamestates and tween
Class = require (lib .. '.lovetoys.lib.middleclass')  --entity-composite-system
--etimer needs Classic (see EnhancedTimer.lua)
Classic = require (lib .. '.classic.classic')         --classes
Timer = require (lib .. '.etimer.EnhancedTimer')      --enhanced Timer
tbl = require (lib .. '.Moses.moses')                 --Tables
splashy = require (lib .. '.splashy')                 --Splash screens
anim8 = require (lib .. '.anim8.anim8')               --Animations
sodapop = require (lib .. '.sodapop.sodapop')         --2ndary Animations
ripple = require (lib .. '.ripple.ripple')            --music/sound
-------------------------------------------------

-- Music/Sound tags
tags = {
  tracks = ripple.newTag(),
  master = ripple.newTag(),
  pianomess = ripple.newTag()
}

-- Sounds
sounds = {
  piano_mess1 = ripple.newSound(audio .. '/music/piano_mess1.ogg', {
    tags = {tags.pianomess},
  }),
  piano_mess2 = ripple.newSound(audio .. '/music/piano_mess2.ogg', {
    tags = {tags.pianomess},
  }),
  piano_mess3 = ripple.newSound(audio .. '/music/piano_mess3.ogg', {
    tags = {tags.pianomess},
  }),
  piano_mess4 = ripple.newSound(audio .. '/music/piano_mess4.ogg', {
    tags = {tags.pianomess},
  }),
  piano_mess5 = ripple.newSound(audio .. '/music/piano_mess5.ogg', {
    tags = {tags.pianomess},
  }),
  piano_mess6 = ripple.newSound(audio .. '/music/piano_mess6.ogg', {
    tags = {tags.pianomess},
  }),
  piano_mess7 = ripple.newSound(audio .. '/music/piano_mess7.ogg', {
    tags = {tags.pianomess},
  })
}

-- Music
music = {
  gamemusic5 = ripple.newSound(audio .. '/music/Game music 5 by Royalty Free Piano.mp3', {
    tags = {tags.tracks},
  }),
  keeponplaying = ripple.newSound(audio .. '/music/Keep On Playing by  Nadia Cripps.ogg', {
    tags = {tags.tracks},
  }),
  halloween = ripple.newSound(audio .. '/music/Halloween Thoughts by Nadia Cripps.ogg', {
    tags = {tags.tracks},
  })
}


-- Importing lovetoys (Entity Systems framework)
-- https://github.com/lovetoys/lovetoys
Lovetoys = require(lib ..".lovetoys.lovetoys")
Lovetoys.initialize({
    globals = true,
    debug = true
})

-- Load Scenes for gamestate
splash =        require(scenes .. '.Splash')
pause =         require(scenes .. '.Pause')
intro =         require(scenes .. '.Intro')
newcareer =     require(scenes .. '.NewCareer')
loadcareer =    require(scenes .. '.LoadCareer')
subway =        require(scenes .. '.Subway')

-- Needed to handle uppercase letters and other "special" keys
utf8 = require("utf8")

-- **** LOAD wordtable WITH FILE OF DICTONARY WORDS ****
wordtable = {}
local file = love.filesystem.newFile(data .."/music.txt","r")
worddata, datasize = file:read()
--print("Data size (bytes): " ..datasize)

-- Exit game if data file is bad
if datasize == 0 then  
  love.window.showMessageBox("Bad data file","Error reading data file. Notify developer for assistance.",{"OK"})
  love.event.quit(0)  
end

for gameword in file:lines() do
	 table.insert(wordtable, gameword)
end

-- print("Max Table index: " ..tbl.size(wordtable))
file:close()
-- **** END OF DICTIONARY ****

-- Load Fonts
font = love.graphics.newFont(gfx .. '/font/font.ttf')
newspaper = love.graphics.newFont(gfx .. '/font/OldNewspaperTypes.ttf',25)
newspaper_sml = love.graphics.newFont(gfx .. '/font/OldNewspaperTypes.ttf',20)
Minecraftia = love.graphics.newFont(gfx .. '/font/Minecraftia.ttf',10)
yapix = love.graphics.newFont(gfx .. '/font/yapix.ttf',32)
pixel8_lrg = love.graphics.newFont(gfx .. '/font/pixel_operator/PixelOperator8-Bold.ttf',20)
pixel8 = love.graphics.newFont(gfx .. '/font/pixel_operator/PixelOperator8.ttf',16)

-- Load Components
Game = require(comp .. '.logic.Game')
Display = require(comp .. '.media.Display')
Word = require(comp .. '.media.Word')
drawString = require(comp .. '.media.drawString')
Position = require(comp .. '.physics.Position')
Velocity = require(comp .. '.physics.Velocity')
IsCurrent = require(comp .. '.identifier.IsCurrent')
IsDead = require(comp .. '.identifier.IsDead')

-- Load Systems
DisplaySystem = require(sys .. '.media.DisplaySystem')
WriteSystem = require(sys .. '.media.WriteSystem')
StringSystem = require(sys .. '.media.StringSystem')
StringSystemCurrent = require(sys .. '.media.StringSystemCurrent')
KillSystem = require(sys .. '.logic.KillSystem')
GameSystem = require(sys .. '.logic.GameSystem')
MoveSystem = require(sys .. '.physics.MoveSystem')

-- Load Event systems
PlayerInputEvent = require(sys .. '.event.PlayerInputEvent')
WordCreatorEvent = require(sys .. '.event.WordCreatorEvent')

-- Load Events
require(events .. '.KeyPressed')
require(events .. '.MousePressed')
require(events .. '.UtfPressed')
require(events .. '.CreateWord')

-- Load global Components
Display,Position,Word,drawString,IsCurrent,IsDead,Velocity,Game = 
Component.load({"Display","Position","Word","drawString","IsCurrent","IsDead","Velocity","Game"})

-- Set global variables
paused = false

-------------------------------------------------
-- **** LOAD ****
-- (--console) to run in command line parameter
function love.load()
  
-- Create new world
World = love.physics.newWorld(0, 0, true)  
-- No need for world collision functions
love.window.setMode(1024, 800, {fullscreen=false, vsync=true, resizable=false})

-- A new instance of an Engine (lovetoys lib)
Engine = Engine()
--Engine_intro = Engine()

-- A new instance of an EventManger (lovetoys lib)
Eventmanager = EventManager()

-- Systems are being added to the engine
Engine:addSystem(DisplaySystem())
Engine:addSystem(WriteSystem())
Engine:addSystem(StringSystem())
Engine:addSystem(StringSystemCurrent())
Engine:addSystem(KillSystem())
Engine:addSystem(MoveSystem())
Engine:addSystem(GameSystem())

-- Add event Listeners
playerinputevent = PlayerInputEvent()
wordcreatorevent = WordCreatorEvent()

-- The playerinputsystem is being registered as a listener for events (see PlayerInputSystem.lua)
Eventmanager:addListener("KeyPressed", playerinputevent, playerinputevent.keypressEvent)
Eventmanager:addListener("MousePressed", playerinputevent, playerinputevent.mousepressEvent)
Eventmanager:addListener("UtfPressed", playerinputevent, playerinputevent.utfEvent)
Eventmanager:addListener("CreateWord", wordcreatorevent, wordcreatorevent.createWord)

Engine_intro = Engine
Engine_new = Engine

-- Register gamestates
Gamestate.registerEvents()
Gamestate.switch(splash)


end

-- **** UPDATE ****
function love.update(dt)

  if not paused and Gamestate.current() ~= splash then
  
    Engine:update(dt)
    World:update(dt)
   -- Engine_intro:update(dt)
   
  end

end

-- DRAW ************
function love.draw()

  if Gamestate.current() ~= pause and Gamestate.current() ~= splash then
    
    Engine:draw()
  
    -- Debug FPS/Delta -------------------
    love.graphics.setColor(240,230,140)
    love.graphics.setFont(Minecraftia)
    local delta = love.timer.getAverageDelta()  
    love.graphics.print("Test Entity System framework", 10, 10)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 30)
    love.graphics.print(string.format("Average frame time: %.3f ms", 1000 * delta), 10, 50) 
    --------------------------------------
  end
 
end

-- **** FUNCTIONS ****
------------------------------------------

-- Capture keys as UTF-8. Needed for capital letters
function love.textinput(key) 
  
  --print("Utfkey: " .. key)  --DEBUG
  
  -- If not already paused and not splash screen
  if not paused and Gamestate.current() ~= splash then
     
      -- Fire generic key menu listener
      Eventmanager:fireEvent(UtfPressed(key))
  
  end

end
-- 

-- Keypresses for function keys and "backspace" aka. clearing IsCurrent
function love.keypressed(key,scancode,isrepeat)
  
  --print("keypress: " .. key)       --DEBUG
  --print("scancode: " .. scancode)  --DEBUG
  
  if scancode == "f2" then
    
    paused = not paused --Pause flag
  
    -- If not already paused and not splash screen
    if paused and Gamestate.current() ~= splash then
        return Gamestate.push(pause)
    end
    
    -- If paused and not splash screen
    if not paused and Gamestate.current() ~= splash then
        return Gamestate.pop(pause)
    end
    
	end
  
  -- If not already paused and not splash screen
  if not paused and Gamestate.current() ~= splash then
      
      if scancode == "escape" then
        Eventmanager:fireEvent(KeyPressed(key,scancode,isrepeat))
      elseif scancode == "backspace" then
        Eventmanager:fireEvent(KeyPressed(key,scancode,isrepeat))
      end      
  end
  
end

function love.mousepressed(x, y, button)
  
  if not paused and Gamestate.current() ~= splash then
      -- Fire mouse click listener
      Eventmanager:fireEvent(MousePressed(x, y, button))
  end
  
end

-- End of Main
-------------------------------------------