local speed = 2
local cellDoors = PartsByNames({"Cell door", "Cell door bar"})

function Start()
	if IsHost then
		for i, door in ipairs(cellDoors) do
			-- Init door moving to false
			if door.table.moving == nil then
				door.table.moving = false
			end

			-- Init door closed to true since closed on start
			if door.table.closed == nil then
				door.table.closed = true
			end

			-- Init each door's closed position
			if door.table.closePos == nil then
				door.table.closePos = door.position
			end

			-- Init each door's open position
			if door.table.openPos == nil then
				door.table.openPos = door.position - newVector3(1.30, 0, 0)
			end
		end
	end
end

function Update()
	if IsHost then
		for i, door in ipairs(cellDoors) do
			-- If door.table.moving is not true, do nothing.
			if door.table.moving then
				if door.table.closed then
					door.position = door.position - newVector3(speed * Time.delta, 0, 0)

					if door.position.x <= door.table.openPos.x then
						door.table.moving = false
						door.table.closed = false
						door.position.x = door.table.openPos.x
					end
				else
					door.position = door.position + newVector3(speed * Time.delta, 0, 0)

					if door.position.x >= door.table.closePos.x then
						door.table.moving = false
						door.table.closed = true
						door.position.x = door.table.closePos.x
					end
				end
			end
		end
	end
end