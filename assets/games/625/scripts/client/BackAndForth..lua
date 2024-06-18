local startX = nil;

local speed = 0.04;
local moveX = speed;

local movementDistance = 25;

function Start()
	startX = This.position.x;
end

function Update()
	if (This.position.x > startX + movementDistance) then
		moveX = -speed;
	elseif (This.position.x < startX) then
		moveX = speed;
	end

	This.position = This.position + newVector3(moveX,0,0);
end


