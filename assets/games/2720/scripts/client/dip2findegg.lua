local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Teardrop Egg! The code for this egg is: ''W5uZ''. I could've sworn this was a flower!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end