-- Word text Component - Handles "whole" words

local Word = Component.create("Word")

function Word:initialize(font, textstring, color)
    self.font = font
    self.textstring = textstring or ''
    self.text = love.graphics.newText(font,textstring)
    self.color = color or {255, 255, 255 ,255}
    self.height = self.text:getHeight()
    self.width = self.text:getWidth()
end
