
local index = 1
local texts = {"Hi", "Welcome to evergreen forest", "This is a demo game", "Nice to meet you"}
-- local iterations = texts.getn -- get size of array

function OnInteracted(character)
	local dialog = object.GetChildByName("text")
	dialog.worldText.text = texts[index]
	index = index + 1
	if (index == 4) then
		index = 1
	end 
end