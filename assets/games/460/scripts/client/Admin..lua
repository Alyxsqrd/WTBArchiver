--[[     ___   __         _        _____                              __
		/ _ | / /_ ____ _( )___   / ___/__  __ _  __ _  ___ ____  ___/ /__
	   / __ |/ / // /\ \ //(_-<  / /__/ _ \/  ' \/  ' \/ _ `/ _ \/ _  (_-<
	  /_/ |_/_/\_, //_\_\ /___/  \___/\___/_/_/_/_/_/_/\_,_/_//_/\_,_/___/
			  /___/

	  Script by Alyx (binary#1337) | v2021.04.18 | Support server: TenrBdJ ]]


------------------
-- Player Lists --
------------------
local Ranks = {
	Owners = {
		Members = {1008, 1228},
		Level = 30
	},
	Administrators = {
		Members = {},
		Level = 20
	},
	Moderators = {
		Members = {},
		Level = 10
	},
	Guest = {
		Level = 0
	}
}

local Banned = {
	[420] = true,
	[1337] = "No cheating!"
}


--------------
-- Settings --
--------------
local Settings = {
	CommandPrefix = "!",
	Debugging = true,
	DefaultRank = "Guest",
	FlySpeed = 0.2,
	Watermark = true
}




--[[                          [  W A R N I N G  ]

EVERYTHING AFTER THIS COMMENT BELONGS TO THE CORE SCRIPT FUNCTIONALITY!
 ANY CHANGES YOU MAKE TO IT ARE YOUR RESPONSIBILITY AND NOT SUPPORTED. ]]


-----------------------
-- Declare Variables --
-----------------------
local Version = "2021.04.18"
local LP, AllCommands, AllHandlers, Shared = LocalPlayer(), {}, {}, {}

local AllLoops = {
	Update = {},
	FixedUpdate = {},
	DrawUpdate = {},
	TurboUpdate = {}
}

local Overlay = MakeUIPanel(newVector2(-4, -4), ScreenSize() + newVector2(8, 8))
Overlay.enabled = false

local Skyboxes = {
	Front = {newVector3(250, 0, 0), newVector3(1, 500, 500)},
	Back = {newVector3(-250, 0, 0), newVector3(1, 500, 500)},
	Top = {newVector3(0, 250, 0), newVector3(500, 1, 500)},
	Bottom = {newVector3(0, -250, 0), newVector3(500, 1, 500)},
	Right = {newVector3(0, 0, 250), newVector3(500, 500, 1)},
	Left = {newVector3(0, 0, -250), newVector3(500, 500, 1)}
}

math.randomseed(os.time())


---------------------
-- Basic Functions --
---------------------
local function Round(number, decimals)
	local mult = 10 ^ (decimals or 0)
	return math.floor(number * mult + 0.5) / mult
end

local function IsEmpty(input)
	if input == nil then
		return true
	elseif type(input) == "string" then
		return string.match(input, "%S") == nil
	elseif type(input) == "table" then
		return next(input) == nil
	end
end

local function KeyPairs(tbl)
	local a = {}

	for n in pairs(tbl) do
		table.insert(a, n)
	end

	table.sort(a)

	local i = 0

	return function()
		i = i + 1

		if a[i] == nil then
			return nil
		else
			return a[i], tbl[a[i]]
		end
	end
end

local function KeyCount(tbl)
	local count = 0

	for k in pairs(tbl) do
		count = count + 1
	end

	return count
end

local function Output(title, message, recipient)
	local output

	if title == 3 and not Settings.Debugging then
		return
	end

	if IsEmpty(title) or title == 0 then
		output = "<b><color=#1e90ff>[Alyx's Commands] Info:</color></b> <color=#6bb6ff>" .. message .. "</color>"
	elseif title == 1 then
		output = "<b><color=#ff6b6c>[Alyx's Commands] Error:</color></b> <color=#ffb8b8>" .. message .. "</color>"
	elseif title == 2 then
		output = "<b><color=#ffb46b>[Alyx's Commands] Warning:</color></b> <color=#ffdbb8>" .. message .. "</color>"
	elseif title == 3 then
		output = "<b><color=#b46bff>[Alyx's Commands] Debug:</color></b> <color=#dbb8ff>" .. message .. "</color>"
	else
		output = "<b><color=#1e90ff>[Alyx's Commands] " .. title .. ":</color></b> <color=#6bb6ff>" .. message .. "</color>"
	end

	if recipient and not recipient.isLocal then
		CreateTalkMessageFor(recipient, output)
	else
		CreateTalkMessage(output)
	end
end

if Settings.Watermark then
	Output("Welcome", "This server is powered by Alyx's Commands v" .. Version .. "!")
end


--------------------
-- Rank Functions --
--------------------
local function GetRankedPlayers()
	local output, sorted = {}, {}

	for rank, data in pairs(Ranks) do
		table.insert(sorted, {rank, data})
	end

	table.sort(sorted, function(a, b) return a[2].Level < b[2].Level end)

	for i, data in ipairs(sorted) do
		if data[2].Members and data[2].Level > 0 then
			for i2, member in ipairs(data[2].Members) do
				table.insert(output, {ID = tonumber(member), Rank = data[1], Level = data[2].Level})
			end
		end
	end

	return output
end

local function GetPlayerRank(player)
	for i, plr in ipairs(GetRankedPlayers()) do
		if plr.ID == player.WTBID then
			return plr.Rank
		end
	end

	return Settings.DefaultRank
end

local function GetPlayerLevel(player)
	for i, plr in ipairs(GetRankedPlayers()) do
		if plr.ID == player.WTBID then
			return plr.Level
		end
	end

	return Ranks[Settings.DefaultRank].Level
end

local function IsAuthorized(invoker, target, strict)
	local invokerLevel = GetPlayerLevel(invoker)
	local targetLevel = GetPlayerLevel(target)

	Output(3, "Invoker: " .. invoker.name .. " (level " .. invokerLevel .. "), target: " .. target.name .. " (level " .. targetLevel .. ").")

	if invoker == target then
		return not strict
	end	

	if strict then
		return invokerLevel > targetLevel
	else
		return invokerLevel >= targetLevel
	end
end


-----------------------
-- Command Functions --
-----------------------
local function AddCommand(commands, arguments, clearance, func)
	if type(commands) ~= "table" then
		commands = {commands}
	end

	local aliases = {}

	for i = 2, #commands do
		table.insert(aliases, string.lower(commands[i]))
	end

	AllCommands[string.lower(commands[1])] = {Aliases = aliases, Arguments = arguments, Clearance = clearance, Execute = func}
end

local function ExecuteCommand(invoker, command, arguments)
	local command = string.lower(command)
	local AC = AllCommands[command]

	if not AC then
		for name, data in pairs(AllCommands) do
			for i, alias in ipairs(data.Aliases) do
				if alias == command then
					AC = data
					break
				end
			end
		end
	end

	if AC then
		if not AC.Clearance or GetPlayerLevel(invoker) >= AC.Clearance then
			--[[ if AC.Arguments and #arguments < AC.Arguments then
				Output(1, "Invalid syntax for \"" .. command .. "\" command.", invoker)
				return
			end ]]

			Output(3, "Executing command \"" .. command .. " " .. table.concat(arguments, " ") .. "\" from " .. invoker.name .. ".")
			AC.Execute(invoker, arguments)
		else
			Output(1, "You do not have permission to use \"" .. command .. "\".", invoker)
		end
	else
		Output(1, "The command \"" .. command .. "\" does not exist.", invoker)
	end
end

local function ParseTargets(invoker, target, singular)
	if IsEmpty(target) then
		return {invoker}
	end

	local result = {}
	local lowered = string.lower(target or "")

	if lowered == "me" then
		return {invoker}
	elseif lowered == "all" and not singular then
		return GetAllPlayers()
	elseif lowered == "host" then
		for i, plr in ipairs(GetAllPlayers()) do
			if plr.isHost then
				return {plr}
			end
		end
	elseif lowered == "others" and not singular then
		for i, plr in ipairs(GetAllPlayers()) do
			if plr ~= invoker then
				table.insert(result, plr)
			end
		end
	elseif lowered == "random" then
		local players = GetAllPlayers()
		return {players[math.random(1, #players)]}
	else
		for i, plr in ipairs(GetAllPlayers()) do
			if lowered == string.sub(string.lower(plr.name), 1, #target) then
				if singular then
					return {plr}
				end

				table.insert(result, plr)
			end
		end
	end

	return result
end


-----------------------
-- Special Functions --
-----------------------
local function ShowNametags(switch, players)
	for i, plr in ipairs(players or GetAllPlayers()) do
		plr.showTag = switch
	end
end

local function Disconnect(type, reason)
	local windowSize, windowPos

	local background = MakeUIPanel(newVector2(-4, -4), ScreenSize() + newVector2(8, 8))
	background.color = newColor(0.02, 0.02, 0.02, 0.96)

	if IsEmpty(reason) or reason == true then
		windowSize = newVector2(480, 40)
	else
		windowSize = newVector2(480, 58)
	end

	local window = MakeUIPanel(newVector2((ScreenSize().x / 2) - (windowSize.x / 2), (ScreenSize().y / 2) - (windowSize.y / 2)), windowSize)
	window.color = newColor(0.1, 0.1, 0.1, 1)

	if not IsEmpty(reason) and reason ~= true then
		local reasonText = MakeUIText(newVector2(0, 36), newVector2(window.size.x, 14), "<b>Reason:</b> " .. reason, window)
		reasonText.textColor = newColor(0.5, 0, 0, 1)
		reasonText.textSize = 12
		reasonText.textAlignment = "MiddleCenter"
	end

	local message = MakeUIText(newVector2(0, 0), newVector2(window.size.x, 40), nil, window)
	message.textColor = newColor(0.8, 0, 0, 1)
	message.textSize = 20
	message.textAlignment = "MiddleCenter"

	if type == 0 then
		message.text = "<b>You have been kicked from this game.</b>"
	elseif type == 1 then
		message.text = "<b>You have been banned from this game.</b>"
	elseif type == 2 then
		message.text = "<b>You are banned from this game.</b>"
	elseif type == 3 then
		message.text = "<b>The server has shut down. Please rejoin.</b>"
	end

	local credit = MakeUIText(newVector2(-2, window.size.y), newVector2(window.size.x, 10), "<b>>> Powered by Alyx's Commands</b>", window)
	credit.textColor = newColor(0.2, 0.2, 0.2, 1)
	credit.textSize = 8
	credit.textAlignment = "MiddleRight"

	ShowNametags(false)
	SetCameraLock(false)

	CreateTimer("AC_Crash", 0.1)
end


---------------------
-- Event Functions --
---------------------
local function AddHandler(name, func)
	AllHandlers[string.lower(name)] = {Execute = func}
end

local function ExecuteHandler(sender, name, data)
	sender = PlayerByID(sender)

	if sender then
		local handler = AllHandlers[string.lower(name)]

		if handler then
			handler.Execute(sender, data)
		else
			Output(1, "Received unregistered handler \"" .. name .. "\" from " .. sender.name .. ".")
		end
	else
		Output(1, "Received handler \"" .. name .. "\" from invalid sender.")
	end
end

local function SendPlayerRequest(sender, recipient, name, data)
	if type(data) ~= "table" then
		data = {data}
	end

	Output(3, "Sending request \"" .. name .. "\" to " .. recipient.name .. ".")

	if recipient.isLocal then
		ExecuteHandler(sender.id, name, data)
	else
		NetworkSendToPlayer("AC_" .. name, {sender.id, table.unpack(data)}, recipient)
	end
end

local function SendHostRequest(name, data)
	if type(data) ~= "table" then
		data = {data}
	end

	Output(3, "Sending request \"" .. name .. "\" to host.")

	if IsHost then
		ExecuteHandler(LP.id, name, data)
	else
		NetworkSendToHost("AC_" .. name, data)
	end
end

local function SendGlobalRequest(sender, name, data)
	if type(data) ~= "table" then
		data = {data}
	end

	Output(3, "Sending request \"" .. name .. "\" to all players.")
	NetworkSendToAll("AC_" .. name, {sender.id, table.unpack(data)})
end

local function GetLoop(name, type)
	name = string.lower(name)

	if type == 0 then
		return AllLoops.Update[name] ~= nil
	elseif type == 1 then
		return AllLoops.FixedUpdate[name] ~= nil
	elseif type == 2 then
		return AllLoops.DrawUpdate[name] ~= nil
	elseif type == 3 then
		return AllLoops.TurboUpdate[name] ~= nil
	else
		Output(1, "Attempted to get invalid loop type (" .. type .. ").")
		return false
	end
end

local function AddLoop(name, type, func)
	name = string.lower(name)

	if type == 0 then
		if not AllLoops.Update[name] then
			AllLoops.Update[name] = {Execute = func}
			return true
		end
	elseif type == 1 then
		if not AllLoops.FixedUpdate[name] then
			AllLoops.FixedUpdate[name] = {Execute = func}
			return true
		end
	elseif type == 2 then
		if not AllLoops.DrawUpdate[name] then
			AllLoops.DrawUpdate[name] = {Execute = func}
			return true
		end
	elseif type == 3 then
		if not AllLoops.TurboUpdate[name] then
			AllLoops.TurboUpdate[name] = {Execute = func}
			return true
		end
	else
		Output(1, "Attempted to add invalid loop type (" .. type .. ").")
		return false
	end

	Output(3, "Attempted to add existing loop \"" .. name .. "\".")
	return false
end

local function RemoveLoop(name, type)
	name = string.lower(name)

	if type == 0 then
		AllLoops.Update[name] = nil
		return true
	elseif type == 1 then
		AllLoops.FixedUpdate[name] = nil
		return true
	elseif type == 2 then
		AllLoops.DrawUpdate[name] = nil
		return true
	elseif type == 3 then
		AllLoops.TurboUpdate[name] = nil
		return true
	else
		Output(1, "Attempted to get invalid loop type (" .. type .. ").")
		return false
	end

	Output(3, "Attempted to remove unregistered loop \"" .. name .. "\".")
	return false
end


------------------------
-- Override Functions --
------------------------
--[[ function InitialPlayerSpawn(player)
	for bannedID, reason in pairs(Banned) do
		if bannedID == player.WTBID and reason ~= false then
			SendPlayerRequest(LP, player, "Kicked", {2, reason})

			Output(3, "Prevented banned user ID " .. player.WTBID .. " from rejoining.")
			break
		end
	end
end ]]

function OnChat(player, message)
	if IsHost and string.sub(message, 1, #Settings.CommandPrefix) == Settings.CommandPrefix then
		message = string.sub(message, #Settings.CommandPrefix + 1)

		local split = {}
		for match in string.gmatch(message, "%S+") do
			table.insert(split, match)
		end

		ExecuteCommand(player, split[1], {table.unpack(split, 2)})
	end
end

function NetworkStringReceive(player, message, data)
	Output(3, "Received network message \"" .. message .. "\" from " .. player.name .. ".")

	if string.sub(message, 1, 3) == "AC_" then
		if IsHost and not player.isLocal then
			ExecuteHandler(player.id, string.sub(message, 4), data)
		else
			ExecuteHandler(data[1], string.sub(message, 4), {table.unpack(data, 2)})
		end
	end
end

function TimerEnd(name)
	if name == "AC_Crash" then
		while true do end
	end
end

function Update()
	for name, loop in pairs(AllLoops.Update) do
		loop.Execute()
	end

	for name, loop in pairs(AllLoops.TurboUpdate) do
		loop.Execute()
	end

	Overlay.size = ScreenSize() + newVector2(8, 8)
end

function FixedUpdate()
	for name, loop in pairs(AllLoops.FixedUpdate) do
		loop.Execute()
	end

	for name, loop in pairs(AllLoops.TurboUpdate) do
		loop.Execute()
	end
end

function DrawUpdate()
	for name, loop in pairs(AllLoops.DrawUpdate) do
		loop.Execute()
	end

	for name, loop in pairs(AllLoops.TurboUpdate) do
		loop.Execute()
	end
end


------------------
-- All Handlers --
------------------
AddHandler("Blind", function(sender, data)
	local switch = data[1]

	if switch == true and not Shared.OverlayMode then
		Shared.OverlayMode = "Blind"
		Overlay.color = newColor(0, 0, 0, 1)

		Overlay.enabled = true
		ShowNametags(false)
	elseif switch == false and Shared.OverlayMode == "Blind" then
		Overlay.enabled = false
		ShowNametags(true)

		Shared.OverlayMode = nil
	end
end)

AddHandler("CheckBan", function(sender, data)
	Output(3, "Querying ban list for user ID " .. sender.WTBID .. ".")

	local banData = Banned[sender.WTBID]

	if banData then
		Output(3, "Preventing banned user ID " .. sender.WTBID .. " from joining.")
		SendPlayerRequest(LP, sender, "Kicked", {2, banData})
	end
end)

AddHandler("ClearChat", function(sender, data)
	for i = 0, 100 do
		CreateTalkMessage("<size=0>.</size>")
	end

	Output(0, "Chat cleared by " .. sender.name .. ".")
end)

AddHandler("Controlled", function(sender, data)
	local switch = data[1]

	if switch == true and not GetLoop("Controlled", 3) and not GetLoop("Controller", 3) then
		AddLoop("Controlled", 3, function()
			if not sender.hasCharacter then
				RemoveLoop("Controlled", 3)

				LP.angles = newVector3(0, LP.angles.y, LP.angles.z)
				LP.frozen = false
				sender.visible = true
				sender.cancollide = true

				return
			end

			LP.frozen = true
			sender.visible = false
			sender.cancollide = false

			LP.position = sender.position
			LP.angles = sender.angles
		end)
	elseif switch == false and GetLoop("Controlled", 3) then
		RemoveLoop("Controlled", 3)

		LP.angles = newVector3(0, LP.angles.y, LP.angles.z)
		LP.frozen = false
		sender.visible = true
		sender.cancollide = true
	end
end)

AddHandler("Controller", function(sender, data)
	local switch = data[1]

	if switch == true and not GetLoop("Controller", 3) and not GetLoop("Controlled", 3) then
		AddLoop("Controller", 3, function()
			if not sender.hasCharacter then
				RemoveLoop("Controller", 3)

				LP.visible = true
				LP.showTag = true
				sender.cancollide = true

				return
			end

			LP.visible = false
			LP.showTag = false
			sender.cancollide = false

			sender.position = LP.position
			sender.angles = LP.angles
		end)
	elseif switch == false and GetLoop("Controller", 3) then
		RemoveLoop("Controller", 3)

		LP.visible = true
		LP.showTag = true
		sender.cancollide = true
	end
end)

AddHandler("Disco", function(sender, data)
	local switch = data[1]

	if switch == true and not GetLoop("Disco", 0) then
		Shared.NextColor = 0
		Shared.HueValue = -1
		Shared.LightParts = {}

		for i, part in ipairs(GetAllParts()) do
			if part.light then
				table.insert(Shared.LightParts, {part, part.light.color, part.light.brightness})
				part.light.brightness = 2
			end
		end

		AddLoop("Disco", 0, function()
			if Time.time >= Shared.NextColor then
				Shared.NextColor = Time.time + 0.01

				if Shared.HueValue < 360 then
					Shared.HueValue = Shared.HueValue + 1
				else
					Shared.HueValue = 0
				end

				local currentColor = Color.HSVToRGB(Shared.HueValue / 360, 1, 1)

				for i, data in ipairs(Shared.LightParts) do
					data[1].light.color = currentColor
				end
			end
		end)
	elseif switch == false and GetLoop("Disco", 0) then
		RemoveLoop("Disco", 0)

		for i, data in ipairs(Shared.LightParts) do
			data[1].light.color = data[2]
			data[1].light.brightness = data[3]
		end

		Shared.NextColor = nil
		Shared.HueValue = nil
		Shared.LightParts = nil
	end
end)

AddHandler("Flash", function(sender, data)
	local switch = data[1]

	if switch == true and not Shared.OverlayMode then
		Shared.NextFlash = 0
		Shared.OverlayMode = "Flash"
		

		AddLoop("Flash", 0, function()
			if Time.time >= Shared.NextFlash then
				Shared.NextFlash = Time.time + 0.1

				if Overlay.color == newColor(1, 1, 1, 1) then
					Overlay.color = newColor(0, 0, 0, 1)
				else
					Overlay.color = newColor(1, 1, 1, 1)
				end
			end
		end)

		Overlay.enabled = true
		ShowNametags(false)
	elseif switch == false and Shared.OverlayMode == "Flash" then
		RemoveLoop("Flash", 0)

		Overlay.enabled = false
		ShowNametags(true)

		Shared.NextFlash = nil
		Shared.OverlayMode = nil
	end
end)

AddHandler("Fly", function(sender, data)
	local switch = data[1]

	if switch == true and not GetLoop("Fly", 0) then
		Shared.FlyVelocity = Vector3.zero

		AddLoop("Fly", 0, function()
			if not LP.frozen then
				LP.frozen = true
			end

			local speed, maxSpeed, stopSpeed, absFVX, absFVY, absFVZ = Settings.FlySpeed, 20, Settings.FlySpeed * 1.5, math.abs(Shared.FlyVelocity.x), math.abs(Shared.FlyVelocity.y), math.abs(Shared.FlyVelocity.z)

			if InputHeld("left shift") then
				speed = speed * 6
				maxSpeed = maxSpeed * 6
			elseif absFVX > maxSpeed or absFVY > maxSpeed or absFVZ > maxSpeed then
				maxSpeed = lerp(math.max(absFVX, absFVY, absFVZ), maxSpeed, speed / 12)
				stopSpeed = stopSpeed * 6
			end

			if InputHeld("w") then Shared.FlyVelocity.z = math.min(maxSpeed, Shared.FlyVelocity.z + speed) elseif Shared.FlyVelocity.z > 0 then Shared.FlyVelocity.z = math.max(0, Shared.FlyVelocity.z - stopSpeed) end
			if InputHeld("s") then Shared.FlyVelocity.z = math.max(-maxSpeed, Shared.FlyVelocity.z - speed) elseif Shared.FlyVelocity.z < 0 then Shared.FlyVelocity.z = math.min(0, Shared.FlyVelocity.z + stopSpeed) end
			if InputHeld("a") then Shared.FlyVelocity.x = math.max(-maxSpeed, Shared.FlyVelocity.x - speed) elseif Shared.FlyVelocity.x < 0 then Shared.FlyVelocity.x = math.min(0, Shared.FlyVelocity.x + stopSpeed) end
			if InputHeld("d") then Shared.FlyVelocity.x = math.min(maxSpeed, Shared.FlyVelocity.x + speed) elseif Shared.FlyVelocity.x > 0 then Shared.FlyVelocity.x = math.max(0, Shared.FlyVelocity.x - stopSpeed) end

			if InputHeld("q") then Shared.FlyVelocity.y = math.min(maxSpeed, Shared.FlyVelocity.y + speed) elseif Shared.FlyVelocity.y > 0 then Shared.FlyVelocity.y = math.max(0, Shared.FlyVelocity.y - stopSpeed) end
			if InputHeld("e") then Shared.FlyVelocity.y = math.max(-maxSpeed, Shared.FlyVelocity.y - speed) elseif Shared.FlyVelocity.y < 0 then Shared.FlyVelocity.y = math.min(0, Shared.FlyVelocity.y + stopSpeed) end

			LP.angles = LP.viewAngles
			LP.position = LP.position + (LP.right * Shared.FlyVelocity.x * Time.delta) + (LP.forward * Shared.FlyVelocity.z * Time.delta) + (LP.up * Shared.FlyVelocity.y * Time.delta)
		end)
	elseif switch == false and GetLoop("Fly", 0) then
		RemoveLoop("Fly", 0)

		LP.frozen = false
		LP.angles = newVector3(0, LP.angles.y, LP.angles.z)

		Shared.FlyVelocity = nil
	end
end)

AddHandler("Kicked", function(sender, data)
	local type, reason = tonumber(data[1]), data[2]

	if type then
		Disconnect(type, reason)
	end
end)

AddHandler("Spin", function(sender, data)
	local switch, speed = data[1], data[2]

	if switch == true then
		Shared.SpinSpeed = speed * 40

		if not GetLoop("Spin", 0) then
			AddLoop("Spin", 0, function()
				LP.angles = LP.angles + newVector3(0, Shared.SpinSpeed * Time.delta, 0)
			end)
		end		
	elseif switch == false and GetLoop("Spin", 0) then
		RemoveLoop("Spin", 0)

		Shared.SpinSpeed = nil
	end
end)

AddHandler("UpdatePlayersSize", function(sender, data)
	local players, size = data[1], data[2]

	for i, netID in ipairs(players) do
		local player = PlayerByID(netID)

		player.size = size
	end
end)

AddHandler("UpdatePlayersVisible", function(sender, data)
	local players, switch = data[1], data[2]

	for i, netID in ipairs(players) do
		local player = PlayerByID(netID)

		player.visible = switch
		player.showTag = switch

		if not player.isLocal then
			player.cancollide = switch
		end
	end
end)

SendHostRequest("CheckBan")


------------------
-- All Commands --
------------------
AddCommand("ban", {"<player>", "[reason]+"}, 10, function(invoker, arguments)
	local targets, reason = ParseTargets(invoker, arguments[1]), table.concat({table.unpack(arguments, 2)}, " ")

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr, true) then
				if not Banned[plr.WTBID] then
					Banned[plr.WTBID] = reason or true
					SendPlayerRequest(invoker, plr, "Kicked", {1, reason})
				else
					Output(1, plr.name .. " is already banned from this server.", invoker)
				end
			else
				Output(1, "You do not have permission to ban " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("clear", {}, 10, function(invoker, arguments)
	SendGlobalRequest(invoker, "ClearChat")
end)

AddCommand({"cmds", "help"}, {}, 0, function(invoker, arguments)
	local output = "\n"
	local count = KeyCount(AllCommands)

	local i = 0

	for name, data in KeyPairs(AllCommands) do
		i = i + 1
		output = output .. Settings.CommandPrefix .. name

		if #data.Arguments > 0 then
			output = output .. " "
			local count2 = #data.Arguments

			for i, argument in ipairs(data.Arguments) do
				argument = string.gsub(argument, "+", "")
				output = output .. argument

				if i < count2 then
					output = output .. " "
				end
			end
		end

		if i < count then
			output = output .. "\n"
		end
	end

	Output("Commands", output, invoker)
end)

AddCommand("blind", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Blind", true)
			else
				Output(1, "You do not have permission to blind " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand({"bring", "tphere"}, {"<player>"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				plr.HostSetPosition(invoker.position)
			else
				Output(1, "You do not have permission to bring " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("control", {"<player>"}, 20, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1], true)

	if not IsEmpty(targets) then
		local plr = targets[1]

		if plr ~= invoker then
			if IsAuthorized(invoker, plr) then
				SendGlobalRequest(invoker, "UpdatePlayersVisible", {{invoker.id}, false})
				SendPlayerRequest(invoker, plr, "Controlled", true)
				SendPlayerRequest(plr, invoker, "Controller", true)
			else
				Output(1, "You do not have permission to control " .. plr.name .. ".", true)
			end
		else
			Output(1, "You can't control your own player.", invoker)
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("disco", {}, 30, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Disco", true)
			else
				Output(1, "You do not have permission to disco " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("flash", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Flash", true)
			else
				Output(1, "You do not have permission to flash " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("fling", {"<player>"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				local vector = {math.random(200, 500), math.random(200, 500), math.random(200, 500)}

				if math.random(0, 1) == 1 then
					vector[1] = -vector[1]
				end

				if math.random(0, 1) == 1 then
					vector[3] = -vector[3]
				end

				plr.HostSetVelocity(newVector3(table.unpack(vector)))
			else
				Output(1, "You do not have permission to fling " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

local bruh

AddCommand("TEST", {}, 10, function(invoker, arguments)
	if not bruh then
		bruh = MakeUIPanel(newVector2(20, 20), newVector2(100, 100))
	else
		bruh.position = newVector2(40, 40)
	end

	--[[ Game.gravity = 0

	AddLoop("Bruh", 0, function()
		if InputPressed("mouse 0") then
			MouseRaycast()
		end
	end) ]]
end)

AddCommand("fly", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Fly", true)
			else
				Output(1, "You do not have permission to fly " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand({"invisible", "invis"}, {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		local affected = {}

		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				table.insert(affected, plr.id)
			else
				Output(1, "You do not have permission to set the visibility of " .. plr.name .. ".", invoker)
			end
		end

		SendGlobalRequest(invoker, "UpdatePlayersVisible", {affected, false})
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("kick", {"<player>", "[reason]+"}, 10, function(invoker, arguments)
	local targets, reason = ParseTargets(invoker, arguments[1]), table.concat({table.unpack(arguments, 2)}, " ")

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr, true) then
				SendPlayerRequest(invoker, plr, "Kicked", {0, reason})
			else
				Output(1, "You do not have permission to kick " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand({"respawn", "reset", "kill"}, {"[player]"}, 0, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				plr.Respawn()
			else
				Output(1, "You do not have permission to respawn " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand({"size", "scale"}, {"[player]", "<size>"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, #arguments == 1 and "me" or arguments[1])
	local size = tonumber(#arguments == 1 and arguments[1] or arguments[2])

	if size then
		if not IsEmpty(targets) then
			local vector = newVector3(size, size, size)
			local affected = {}

			for i, plr in ipairs(targets) do
				if IsAuthorized(invoker, plr) then
					table.insert(affected, plr.id)
				else
					Output(1, "You do not have permission to set the size of " .. plr.name .. ".", invoker)
				end
			end

			SendGlobalRequest(invoker, "UpdatePlayersSize", {affected, vector})
		else
			Output(1, "No players found in specified target.", invoker)
		end
	else
		Output(1, "Invalid player size.", invoker)
	end
end)

AddCommand("shutdown", {"[reason]+"}, 30, function(invoker, arguments)
	local reason = table.concat(arguments, " ")

	SendGlobalRequest(invoker, "Kicked", {3, reason})
end)

AddCommand("speed", {"[player]", "<speed>"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, #arguments == 1 and "me" or arguments[1])
	local speed = tonumber(#arguments == 1 and arguments[1] or arguments[2])

	if speed then
		if not IsEmpty(targets) then
			for i, plr in ipairs(targets) do
				if IsAuthorized(invoker, plr) then
					plr.HostSetSpeed(speed)
				else
					Output(1, "You do not have permission to set the speed of " .. plr.name .. ".", invoker)
				end
			end
		else
			Output(1, "No players found in specified target.", invoker)
		end
	else
		Output(1, "Invalid player speed.", invoker)
	end
end)

AddCommand("spin", {"[player]", "<speed>"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, #arguments == 1 and "me" or arguments[1])
	local speed = tonumber(#arguments == 1 and arguments[1] or arguments[2]) or 1

	if speed then
		if not IsEmpty(targets) then
			for i, plr in ipairs(targets) do
				if IsAuthorized(invoker, plr) then
					SendPlayerRequest(invoker, plr, "Spin", {true, speed})
				else
					Output(1, "You do not have permission to spin " .. plr.name .. ".", invoker)
				end
			end
		else
			Output(1, "No players found in specified target.", invoker)
		end
	else
		Output(1, "Invalid spin speed.", invoker)
	end
end)

AddCommand({"to", "goto"}, {"<player>"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1], true)

	if not IsEmpty(targets) then
		invoker.HostSetPosition(targets[1].position)
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("unban", {"<userID>"}, 10, function(invoker, arguments)
	local userID = tonumber(arguments[1])

	if userID then
		if Banned[userID] then
			Banned[userID] = nil
			Output(0, "Unbanned user ID " .. bannedID .. ".", invoker)
		else
			Output(1, "User ID not found in ban list.", invoker)
		end
	else
		Output(1, "Invalid user ID.", invoker)
	end
end)

AddCommand("unblind", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Blind", false)
			else
				Output(1, "You do not have permission to unblind " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("uncontrol", {"<player>"}, 20, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1], true)

	if not IsEmpty(targets) then
		local plr = targets[1]

		if plr ~= invoker then
			if IsAuthorized(invoker, plr) then
				SendGlobalRequest(invoker, "UpdatePlayersVisible", {{invoker.id}, true})
				SendPlayerRequest(invoker, plr, "Controlled", false)
				SendPlayerRequest(plr, invoker, "Controller", false)
			else
				Output(1, "You do not have permission to uncontrol " .. plr.name .. ".", true)
			end
		else
			Output(1, "You can't uncontrol your own player.", invoker)
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("undisco", {}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Disco", false)
			else
				Output(1, "You do not have permission to undisco " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("unflash", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Flash", false)
			else
				Output(1, "You do not have permission to unflash " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("unfly", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Fly", false)
			else
				Output(1, "You do not have permission to unfly " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand({"unsize", "unscale"}, {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		local vector = newVector3(1, 1, 1)
		local affected = {}

		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				table.insert(affected, plr.id)
			else
				Output(1, "You do not have permission to unset the size of " .. plr.name .. ".", invoker)
			end
		end

		SendGlobalRequest(invoker, "UpdatePlayersSize", {affected, vector})
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("unspeed", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				plr.HostSetSpeed(9)
			else
				Output(1, "You do not have permission to unset the speed of " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand("unspin", {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				SendPlayerRequest(invoker, plr, "Spin", false)
			else
				Output(1, "You do not have permission to unspin " .. plr.name .. ".", invoker)
			end
		end
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)

AddCommand({"visible", "vis"}, {"[player]"}, 10, function(invoker, arguments)
	local targets = ParseTargets(invoker, arguments[1])

	if not IsEmpty(targets) then
		local affected = {}

		for i, plr in ipairs(targets) do
			if IsAuthorized(invoker, plr) then
				table.insert(affected, plr.id)
			else
				Output(1, "You do not have permission to set the visibility of " .. plr.name .. ".", invoker)
			end
		end

		SendGlobalRequest(invoker, "UpdatePlayersVisible", {affected, true})
	else
		Output(1, "No players found in specified target.", invoker)
	end
end)