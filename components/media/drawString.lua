-- drawString Component - Handles words that need to be a series of characters
-- For example: words that the user will be typing

local drawString = Component.create("drawString")

function drawString:initialize(font, astring, color, type, points)
    self.font = font or font
    self.length = #astring
    self.current = false
    self.color = color or {255, 255, 255 ,255}
    self.type = type or 'general'
    self.points = points or 50
    
    -- String
    self.astring = astring or ''   
    
    -- Drawable String (not used)
    -- self.stringdraw = love.graphics.newText(font,self.astring)
    
end
