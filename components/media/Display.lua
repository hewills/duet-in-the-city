-- Display image component
local Display = Component.create("Display")

-- Image display components
function Display:initialize(image, x, y, r, sx, sy, ox, oy, kx, ky, color)
  
    self.image = love.graphics.newImage(image) -- Create image
        
    -- Defaults
    self.x = x or 0
    self.y = y or 0
    self.color = color or {255, 255, 255 ,255}
    
    -- Optional
    if r then self.r = r end
    if sx then self.sx = sx  end
    if sy then self.sy = sy  end
    if ox then self.ox = ox  end
    if oy then self.oy = oy  end
    if kx then self.kx = kx  end
    if ky then self.ky = ky  end
end
