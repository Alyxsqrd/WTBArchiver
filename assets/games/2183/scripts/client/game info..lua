function OnConnect(player)
local extScript = PartByName("lab1").scripts[1]
 local lab1o = (extScript["variableOne"])
if lab1o == "no" then
extScript["variableOne1"] = player.name
end
end
function OnDisconnect(player)
if player == lab1owner then
local lab1owner = nobodys 
local lab1 = lab1text
lab1.text.text = "nobodys lab"
end
end
