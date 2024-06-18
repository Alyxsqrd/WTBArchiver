math.randomseed(os.time())

local running = false
local direction = 1

function TimerEnd(name)
	if name == "StartRotate" then
		running = true
	end
end

function Update()
	if running then
		if direction == 1 and This.angles.z >= 20 and This.angles.z < 340 then
			direction = 2
		elseif direction == 2 and This.angles.z <= 340 and This.angles.z > 20 then
			direction = 1
		end

		if direction == 1 then
			This.angles = This.angles + newVector3(0, 0, 40 * Time.delta)
		elseif direction == 2 then
			This.angles = This.angles - newVector3(0, 0, 40 * Time.delta)
		end
	end
end

CreateTimer("StartRotate", math.random() + math.random(1, 5))