local keycardDoor = PartByName("Hall door")
local keycardAccess = PartsByName("Hall indicator light")

function StartCollision(other)
	if other.type == "Player" then
		keycardDoor.visible = false
		keycardDoor.cancollide = false

		for i, child in ipairs(keycardDoor.Children()) do
			child.visible = false
			child.cancollide = false
		end

		for i, child in ipairs(keycardAccess) do
			child.color = newColor(0, 2, 0, 1)
		end

		CreateTimer("CloseDoor_" .. keycardDoor.id, 2)
	end
end

function TimerEnd(name)
	if name == "CloseDoor_" .. keycardDoor.id then
		keycardDoor.visible = true
		keycardDoor.cancollide = true

		for i, child in ipairs(keycardDoor.Children()) do
			child.visible = true
			child.cancollide = true
		end

		for i, child in ipairs(keycardAccess) do
			child.color = newColor(2, 0, 0, 1)
		end
	end
end