function Tick()
	if Input.LeftMousePressed() then
	  shot()
	end
end

function shot()
	local range = 20
   	print("shoot")
  	-- find the position the player is shooting at
  	local shootpos = GetLocalCharacter().cameraPosition + GetLocalCharacter().cameraDirection * range
	print(shootpos)
	-- draw a line between the player and where they're looking
  	local hitdata = RayCast(GetLocalCharacter().cameraPosition, GetLocalCharacter().cameraDirection, range)
	print(htidata)
  	-- make an emptry variable for the player
  	local hitplayer = nil
  	if (hitdata.hitWildcard ~= nil and hitdata.hitWildcard.type == IsComponent(true)) then
	  print("hit")
	  hitplayer = hitdata.hitWildcard
  	end

	if (hitplayer ~= nil) then
   		print("hit")
           NetMessagePlayer("kill", GetHostPlayer(), hitplayer)
  	end
end

function OnNetMessage(msgName, hitplayer)
	if (msgName == "kill" and GetLocalPlayer().isHost == true) then
		print(hitplayer)
	end
 end