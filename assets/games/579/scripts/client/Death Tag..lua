local currentRound, roster, survivors, death, starting, playing = 0, {}, {} -- DON'T TOUCH

local intermissionSeconds = 20
local headstartSeconds = 25
local roundSeconds = 180

local spawnpoints = {"Spawn1", "Spawn2", "Spawn3"}
local lobbySpawn = PartByName("Lobby")
local deathSpawn = PartByName("DeathSpawn")

local panel = MakeUIPanel(newVector2(0, 0), newVector2(400, 50))
panel.color = newColor(0.8, 0, 0, 0.8)

local status = MakeUIText(newVector2(0, 0), newVector2(400, 50), nil, panel)
status.textSize = 24
status.textAlignment = "MiddleCenter"


local function ChangeMessage(message, target)
	if target then
		if target == LocalPlayer() then
			status.text = message
		else
			NetworkSendToPlayer("UpdateStatus", {message}, target)
		end
	else
		status.text = message
		NetworkSendToAll("UpdateStatus", {message})
	end
end

local function ShowTags(switch, players, fromHost)
	if IsHost then
		for k, v in pairs(survivors) do
			v.showTag = switch
		end
	else
		NetworkSendToAll("UpdateTags", {switch, players})
	end
end

local function StartGame()
	local roster = GetAllPlayers()
	currentRound = currentRound + 1

	if currentRound == 1 then
		death = roster[math.random(1, #roster)]
	else
		local temp

		repeat
			temp = roster[math.random(1, #roster)]
		until temp ~= death

		death = temp
	end

	ChangeMessage("<b>Death:</b> " .. death.name)

	for k, v in pairs(roster) do
		if v ~= death then
			local spawn = PartByName(spawnpoints[math.random(1, #spawnpoints)])
			v.HostSetPosition(spawn.position + newVector3(0, spawn.size.y / 2, 0))

			table.insert(survivors, v)
		end
		death.HostSetPosition(deathSpawn.position + newVector3(0, deathSpawn.size.y / 2, 0))
	end

	ShowTags(false, survivors)

	CreateTimer("Headstart", 10)
end

local function ReleaseDeath()
	local spawn = PartByName(spawnpoints[math.random(1, #spawnpoints)])

	death.table.participating = true
	death.HostSetPosition(spawn.position + newVector3(0, spawn.size.y / 2, 0))
	death.speed = 11

	playing = true
	starting = false


	CreateTimer("Round", 1)
end

local function EndGame()
	if #survivors > 0 then
		ChangeMessage("<b>Survivors win...</b>")
	else
		ChangeMessage("<b>Death wins...</b>")
	end

	ShowTags(true, survivors)

	for k, v in pairs(survivors) do
		v.HostSetPosition(lobbySpawn.position + newVector3(0, lobbySpawn.size.y / 2, 0))
		table.remove(survivors, k)
	end
	death.HostSetPosition(lobbySpawn.position + newVector3(0, lobbySpawn.size.y / 2, 0))
	death.speed = 9

	headstartSeconds = 25
	intermissionSeconds = 20
	roundSeconds = 180

	playing = false
	starting = false
end

function Update()
	if IsHost then
		local roster = GetAllPlayers()
		if not starting and not playing then
			if #roster >= 2 then
				starting = true
				CreateTimer("Intermission", 1)
			else
				if status.text ~= "<b>Waiting for players...</b>" and not playing then
					ChangeMessage("<b>Waiting for players...</b>")
				end
			end
		end

		if playing then
			for k, v in pairs(survivors) do
				if Vector3.Distance(v.position, death.position) <= 1.5 then
					v.HostSetPosition(lobbySpawn.position + newVector3(0, lobbySpawn.size.y / 2, 0))
					table.remove(survivors, k)
					survivors = survivors - 1
				end
			end
		end
	end

	panel.position = newVector2(ScreenSize().x / 2 - panel.size.x / 2, -ScreenSize().y + 10)
end

function TimerEnd(name)
	print(name)
	print(intermissionSeconds)

	if name == "Intermission" then
		if intermissionSeconds > 0 then
			intermissionSeconds = intermissionSeconds - 1
			ChangeMessage("<b>Intermission:</b> " .. intermissionSeconds)

			CreateTimer("Intermission", 1)
		else
			StartGame()
		end

	elseif name == "Headstart" then
		if headstartSeconds > 0 then
			headstartSeconds = headstartSeconds - 1
			ChangeMessage("<b>Headstart:</b> " .. headstartSeconds)

			CreateTimer("Headstart", 1)
		else
			ReleaseDeath()
		end

	elseif name == "Round" then
		if roundSeconds > 0 and #survivors > 0 then
			roundSeconds = roundSeconds - 1

			local h = math.floor(roundSeconds / 3600)
			local m = math.floor(roundSeconds / 60 - (h * 60))
			local s = math.floor(roundSeconds - h * 3600 - m * 60)

			ChangeMessage("<b>" .. m .. ":" .. string.format("%02d", s) .. "</b>")

			CreateTimer("Round", 1)
		else
			EndGame()
		end
	end
end

function PlayerSpawn(player)
	if not starting or playing then
		for k, v in pairs(roster) do
			if v == player then
				return
			end
		end

		table.insert(roster, player)
	end
end

function OnDisconnect(player)
	for k, v in pairs(roster) do
		if v == player then
			table.remove(roster, k)
			break
		end
	end

	for k, v in pairs(survivors) do
		if v == player then
			table.remove(survivors, k)
			break
		end
	end
end

function NetworkStringReceive(player, message, data)
	if message == "UpdateStatus" then
		status.text = data[1]
	elseif message == "QueryText" then
		NetworkSendToPlayer("UpdateStatus", {status.text}, player)
	elseif message == "UpdateTags" then
		ShowTags(data[1], data[2], true)
	end
end

if not IsHost then
	NetworkSendToHost("QueryText", {})
end
