local timeBetweenChecks = 0.33
local distanceForTag = 5

local roundTimer = 120
local intermissionTimer = 15
local timeLeft = 0
local isIntermission = true

local playerManager = PartByName("Player Manager")
local playerTracker = PartByName("Player Tracker")
local gameController = PartByName("Game Controller")
local goldenBall = PartByName("Golden Ball")
local uiManager = PartByName("UI Manager")
local timerTable = PartByName("Timer Table")

local newlyTaggedDelay = 3
local tagged = false
local tagCanBeTaken = true


function Start()
	goldenBall.size = newVector3(distanceForTag * 1.5, distanceForTag * 1.5, distanceForTag * 1.5)
	CreateTimer("foo", 1)

	if (IsHost) then
		Intermission()
	end
end

function TimerEnd(name)
	if (name == "foo") then
		CheckPlayers()
		CreateTimer("bar", timeBetweenChecks)
	end
	if (name == "bar") then
		CheckPlayers()
		CreateTimer("foo", timeBetweenChecks)
	end
	if (name == "newlyTaggedTimer") then
		tagCanBeTaken = true
	end

	if (name == "timer") then
		if (timeLeft > 0) then
			timeLeft = timeLeft - 1
			UpdateTimer()
			CreateTimer("timerstart", 0)
		else
			if (isIntermission) then
				RoundStart()
			else
				RoundEnd()
			end
		end
	end
	if (name == "timerstart") then
		CreateTimer("timer", 1)
	end
end

function CheckPlayers()
	if (playerManager.table["taggerNetId"] == nil or playerManager.table["taggerNetId"] == -1 or PlayerByID(playerManager.table["taggerNetId"]) == nil) then
		tagged = false
		return
	end
	
	if (playerManager.table["taggerNetId"] == LocalPlayer().id and tagged == false) then
		tagged = true
		tagCanBeTaken = false

		CreateTimer("newlyTaggedTimer", newlyTaggedDelay)

		ResetPlayerPositions()
	end

	if (tagged and tagCanBeTaken) then
		for i,v in pairs (playerTracker.table) do
			if (playerTracker.table[i] != LocalPlayer()) then
				local myPosition = LocalPlayer().position
				local otherPosition = playerTracker.table[i].position
				local distanceToPlayer = Vector3.Distance(otherPosition, myPosition)

				if (distanceToPlayer < distanceForTag) then
					--print("Close enough! "..i.." playerNetId is "..playerNetId)
					PlayerTaggedMe(playerTracker.table[i].id)
				end
			end
		end
	end
end

function UpdateTimer()
	print("updating timer.. "..timeLeft)
	uiManager.table["timer"].text = ""..timeLeft
	if (isIntermission) then
		uiManager.table["timerText"].text = "Intermission"
	else
		uiManager.table["timerText"].text = "Round timer"
	end

	if (IsHost) then
		timerTable.table["timeLeft"] = timeLeft
		timerTable.table["intermission"] = isIntermission
		ShareHostData(timerTable.table)
	end
end

function Intermission()
	print("INTERMISSION")
	timeLeft = intermissionTimer
	isIntermission = true
	UpdateTimer()
	CreateTimer("timer", 1)
	
	playerManager.table["taggerNetId"] = -1
	NetworkSendToAll("playerTaggedConfirm", playerManager.table)
end

function RoundEnd()
	print("ROUND END")
	if (IsHost) then
		Intermission()
		ResetPlayersToLobby()
	end
end

function RoundStart()
	print("ROUND START")
	timeLeft = roundTimer
	isIntermission = false
	UpdateTimer()
	CreateTimer("timer", 1)

	print("ROUND START 2")
	TagRandom()
end

function TagRandom()
	if (IsHost) then
		-- randomly tag a player
		local playerCount = 0
		for i,v in pairs(GetAllPlayers()) do
			playerCount = playerCount + 1
		end
		local randomNumber = math.random(0, playerCount)
		print("playerCount = "..playerCount)

		print("ROUND START 3")
		print("random number = "..randomNumber)
		for i,v in pairs(GetAllPlayers()) do
			print("i = "..i)
			if (randomNumber == i) then
				playerManager.table["taggerNetId"] = v.id
				NetworkSendToAll("playerTaggedConfirm", playerManager.table)
				return
			end
		end

		-- tag self if nothing happens
		playerManager.table["taggerNetId"] = LocalPlayer().id
		NetworkSendToAll("playerTaggedConfirm", playerManager.table)
	end
end

function ResetPlayerPositions()
	if (IsHost) then
		local notTaggedSpawn = PartByName("Not Tagged Spawn")
		local taggedSpawn = PartByName("Tagged Spawn")

		for i,v in pairs(GetAllPlayers()) do
			if (v.id == playerManager.table["taggerNetId"]) then
				v.HostSetPosition(taggedSpawn.position)
			else
				v.HostSetPosition(notTaggedSpawn.position)
			end
		end
	else
		NetworkSendToHost("resetPositions", playerManager.table)
	end
end

function ResetPlayersToLobby()
	if (IsHost) then
		local lobbySpawn = PartByName("Lobby Spawn")

		for i,v in pairs(GetAllPlayers()) do
			v.HostSetPosition(lobbySpawn.position)
		end
	else
		NetworkSendToHost("resetPositionsToLobby", gameManager.table)
	end
end

function PlayerTaggedMe(playerNetId)
	--local player = PlayerByID(playerNetId)
	--print("Player "..player.name.." just tagged me")

	tagged = false

	playerManager.table["taggerNetId"] = playerNetId

	if (IsHost) then
		NetworkSendToAll("playerTaggedConfirm", playerManager.table)
	else
		NetworkSendToHost("playerTagged", playerManager.table)
	end
end

function ReceiveHostData(data)
	timeLeft = data["timeLeft"]
	isIntermission = data["intermission"]
	UpdateTimer()
end

function NetworkStringReceive(player, messageName, data)
	if (messageName == "playerTagged" or messageName == "playerTaggedConfirm") then

		tagged = false
		playerManager.table["taggerNetId"] = data["taggerNetId"]

		if (IsHost and messageName == "playerTagged") then
			NetworkSendToAll("playerTaggedConfirm", playerManager.table)
		end
	end
	if (messageName == "resetPositions") then
		ResetPlayerPositions()
	end
	if (messageName == "roundStart") then
		PlayerTaggedMe(LocalPlayer().id)
	end
	if (messageName == "resetPositionsToLobby") then
		ResetPlayersToLobby()
	end
end

function HostSwitched(isNewHost)
	playerManager.table = nil
end