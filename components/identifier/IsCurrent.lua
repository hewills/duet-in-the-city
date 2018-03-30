-- Track word currently being typed by Player

local IsCurrent = Component.create("IsCurrent")

function IsCurrent:initialize(charidx,color)
  self.charidx = charidx or 1
  self.color = color or {255, 0, 0 ,255}
end