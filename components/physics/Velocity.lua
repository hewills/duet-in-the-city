-- Velocity component
local Velocity  = Component.create("Velocity")

function Velocity:initialize(speed, bounce)
    self.speed = speed or 0
    self.bounce = bounce or 0
end
