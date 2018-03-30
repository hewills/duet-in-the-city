MousePressed = class("MousePressed")

function MousePressed:initialize(x, y, button)
    self.button = button
    self.mousey = y
    self.mousex = x
end