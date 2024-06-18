print("World ID: " .. Game.worldID)
print("World name: " .. Game.worldName)
print("World owner: " .. Game.ownerID)
print("Max players: " .. Game.maxPlayers)
print("In test mode: " .. tostring(Game.isTestMode))

local me = LocalPlayer()

function Update()
	if InputPressed("q") then
		me.visible = not me.visible
	end
end

function OnConnected(player)
	print("Bruh... " .. player.name .. " (" .. player.id .. ") joined da game! :)")
end

function OnDisconnected(player)
	print("Hurb... " .. player.name .. " (" .. player.id .. ") left da game! :)")
end

function OnSpawn(player)
	print("Yoo... " .. player.name .. " (" .. player.id .. ") just spawnt in da game! :)")
end

function OnInitialSpawn(player)
	print("Yoo... " .. player.name .. " (" .. player.id .. ") just intially spawnt in da game! :)")
end