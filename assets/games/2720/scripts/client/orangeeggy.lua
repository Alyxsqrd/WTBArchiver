local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Orange Egg! The code for this egg is: ''K9tL''. Not gonna lie, this looks exactly the same as the Yellow Egg, if you haven't found that one yet, whoops.")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end