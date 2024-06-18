local Player = GetLocalPlayer()
local touch = 1

function OnMouseClick()
	if touch == 1 then
		object.sound.PlayLocal()
		Player.SendSystemChat("Eggster: You've found the Treasured Amethyst Blossom Egg! The code for this egg is: ''7Gys''. It seems to be growing some sort of flower..")	
		object.voxelRenderer.transparency = 100
		touch = 0
	end
end