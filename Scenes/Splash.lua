-- Splash Screen intro
local Splash = Classic:extend()

function Splash:enter()

  -- Splash Screen images
	splashy.addSplash(love.graphics.newImage(gfx .. "/img/splash/love.png"),2)
  splashy.addSplash(love.graphics.newImage(gfx .. "/img/splash/underfoot.png"),3)
------------------------
  splashy.onComplete(function() Gamestate.switch(intro) end) 
  
end

function Splash:draw()
  splashy.draw()  -- Draws the splashes to the screen.
end

function Splash:update(dt)
  splashy.update(dt) -- Updates the fading of the splash images.  
end

function Splash:keypressed(key,isrepeat)

	if key == "space" then
		splashy.skipSplash() -- Skips the current splash to the next one.
	elseif key == "escape" then
		splashy.skipAll() -- Skips all splash screens.
	end

end

return Splash
