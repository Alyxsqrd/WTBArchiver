local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Brown Warped Egg! The code for this egg is: ''fG6L''. It sorta looks like it's wearing an upside down crown.. right?")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end