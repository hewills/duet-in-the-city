KeyPressed = class("KeyPressed")

function KeyPressed:initialize(key, scancode, isrepeat)
    self.key = key
    self.scancode = scancode
    self.isrepeat = isrepeat
end
