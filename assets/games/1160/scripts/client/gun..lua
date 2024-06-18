function Update()
 	if (InputPressed("mouse 0") and InputHeld("1")) then

   	local pos = MousePosWorld()

    if (not IsHost) then
     	NetworkSendToHost("Explode", {x = pos.x, y = pos.y, z = pos.z})
    else
 	 	 	BlowUp(pos)
 	 	end
  end
end

function NetworkStringReceive(_player, _msgName, _msg)
	if (_msgName == "Explode") then
		BlowUp(newVector3(_msg.x, _msg.y, _msg.z))
	end
end

function BlowUp(_pos)
	Explode(_pos, 10, 100)
end