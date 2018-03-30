local AudioSystem = class("AudioSystem", System)

function AudioSystem:update(dt)
  --gets timer from class object Timing and adds delta
	for index, value in pairs(self.targets) do
		value:get("Audio").timer = value:get("Audio").timer+dt

	end
end


function AudioSystem:requires()
	return {"Audio"}
end

return AudioSystem
