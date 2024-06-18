local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Legendary Dippy Egg! The code for this egg is: ''eH3b''. We're lucky it hasn't sunken yet!")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end