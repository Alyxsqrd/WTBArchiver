local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Amethyst Egg! The code for this egg is: ''M2rG''. It's very shiny.")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end