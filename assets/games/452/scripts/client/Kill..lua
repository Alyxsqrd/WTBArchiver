function StartCollision(other)
    if IsHost and other.type == "Player" then
        other.position = newVector3(0, -250, 0)
    end
end





local LP = LocalPlayer()

local Settings = {FlySpeed = 0.2}
local Shared = {FlyVelocity = Vector3.zero}

function Update()
	if not LP.frozen then
		LP.frozen = true
	end

	local speed, maxSpeed, stopSpeed, absFVX, absFVY, absFVZ = Settings.FlySpeed, 20, Settings.FlySpeed * 1.5, math.abs(Shared.FlyVelocity.x), math.abs(Shared.FlyVelocity.y), math.abs(Shared.FlyVelocity.z)

	if InputHeld("left shift") then
		speed = speed * 6
		maxSpeed = maxSpeed * 6
	elseif absFVX > maxSpeed or absFVY > maxSpeed or absFVZ > maxSpeed then
		maxSpeed = lerp(math.max(absFVX, absFVY, absFVZ), maxSpeed, speed / 12)
		stopSpeed = stopSpeed * 6
	end

	if InputHeld("w") then Shared.FlyVelocity.z = math.min(maxSpeed, Shared.FlyVelocity.z + speed) elseif Shared.FlyVelocity.z > 0 then Shared.FlyVelocity.z = math.max(0, Shared.FlyVelocity.z - stopSpeed) end
	if InputHeld("s") then Shared.FlyVelocity.z = math.max(-maxSpeed, Shared.FlyVelocity.z - speed) elseif Shared.FlyVelocity.z < 0 then Shared.FlyVelocity.z = math.min(0, Shared.FlyVelocity.z + stopSpeed) end
	if InputHeld("a") then Shared.FlyVelocity.x = math.max(-maxSpeed, Shared.FlyVelocity.x - speed) elseif Shared.FlyVelocity.x < 0 then Shared.FlyVelocity.x = math.min(0, Shared.FlyVelocity.x + stopSpeed) end
	if InputHeld("d") then Shared.FlyVelocity.x = math.min(maxSpeed, Shared.FlyVelocity.x + speed) elseif Shared.FlyVelocity.x > 0 then Shared.FlyVelocity.x = math.max(0, Shared.FlyVelocity.x - stopSpeed) end

	if InputHeld("q") then Shared.FlyVelocity.y = math.min(maxSpeed, Shared.FlyVelocity.y + speed) elseif Shared.FlyVelocity.y > 0 then Shared.FlyVelocity.y = math.max(0, Shared.FlyVelocity.y - stopSpeed) end
	if InputHeld("e") then Shared.FlyVelocity.y = math.max(-maxSpeed, Shared.FlyVelocity.y - speed) elseif Shared.FlyVelocity.y < 0 then Shared.FlyVelocity.y = math.min(0, Shared.FlyVelocity.y + stopSpeed) end

	LP.angles = LP.viewAngles
	LP.position = LP.position + (LP.right * Shared.FlyVelocity.x * Time.delta) + (LP.forward * Shared.FlyVelocity.z * Time.delta) + (LP.up * Shared.FlyVelocity.y * Time.delta)
end