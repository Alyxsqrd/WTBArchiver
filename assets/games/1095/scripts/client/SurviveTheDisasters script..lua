local status = GetObjectByName("Status")
local Lobby = GetObjectByName("Lobby")
local Intermission = 25
local Waiting = 10
local Ending = 5

local Meteors = 0
local RemovingMeteors = 0
local Rounds = 0

local FloodPart = GetObjectByName("Flood")
local TsunamiPart = GetObjectByName("Tsunami")
local MeteorPart = GetObjectByName("Meteor")
local Map = GetObjectByName("House")

local MeteorStarting = false

local spawnpoints = {"Spawn1", "Spawn2", "Spawn3"}

local Disasters = {"Meteors", "Flood", "Tsunami"}
local DisasterChosen

Playing = false

Survivors = {}

local function ChangeMessage(message)
	status.worldtext.Text = message
end

local function CreateDisaster(DisasterName)
	Playing = true
    if DisasterName == "Flood" then
		timer("MoveFlood", 0)
	elseif DisasterName == "Tsunami" then
		timer("MoveTsunami", 0)
	elseif DisasterName == "Meteors" then
		timer("CreateMeteor", 0)
    end
end

local function EndGame()

	FloodPart.position = Vector3.New(FloodPart.position.x, -10.51624, FloodPart.position.z)
	TsunamiPart.position = Vector3.New(TsunamiPart.position.x, TsunamiPart.position.y, -279.061)
	local SurvivorsMessage = "" 
	for k,plr in pairs(GetAllPlayers()) do
		if Survivors[plr] then
			SurvivorsMessage = SurvivorsMessage .. plr.name..", "
			Survivors[plr] = false
			plr.position = Lobby.position + Vector3.New(0, Lobby.size.y * 1.5, 0))
		end
	end
	if SurvivorsMessage ~= "" then
		ChangeMessage("<b>Survivors:</b> " .. SurvivorsMessage)
	else
		ChangeMessage("<b>No One Survived!</b>")
	end
	
	Intermission = 25
	Waiting = 10
	Ending = 5
	Playing = false
	Meteors = 0
	RemovingMeteors = 0
    timer("Intermission", 4)
end

function StartGame()
	if Rounds == 6 then
		ChangeMessage("<b>Regenerating Map...</b>")
		timer("Regenerating", 3)
	else
		DisasterChosen = Disasters[math.random(1, #Disasters)]
		ChangeMessage("<b>Disaster:</b> ".. DisasterChosen)
		Rounds = Rounds + 1
		if Rounds == 1 then
			for k,v in pairs(GetAllObjects()) do
				if v.name == "Map" then
					NewMap = v.Duplicate()
					NewMap.name = "NewMap"
					NewMap.visible = false
					NewMap.cancollide = false
				end
			end
		end
		timer("Playing", 3)
	end
end

function TimerEnd(name)
    if name == "Intermission" then
        if Intermission > 0 then
           	ChangeMessage("<b>Intermission..</b> "..Intermission)
        	Intermission = Intermission - 1
            timer("Intermission", 1)
        else
            StartGame()
        end
        
    elseif name == "Playing" then

		for k,v in pairs(GetAllPlayers()) do 
			local Spawn = GetObjectByName(spawnpoints[math.random(1, #spawnpoints)])
			v.position = Spawn.position + Vector3.New(0, Spawn.size.y / 2, 0)
			Survivors[v] = true
			Playing = true
		end
		timer("Waiting", 1)
		

	elseif name == "MoveFlood" then
        if FloodPart.position.y < 10 then
            FloodPart.position = Vector3.New(FloodPart.position.x, FloodPart.position.y + .5, FloodPart.position.z)
            timer("MoveFlood", 0.26)
        else
            timer("Ending", 0)
		end
	elseif name == "MoveTsunami" then
		if TsunamiPart.position.z <= -91.60468 then
            TsunamiPart.position = Vector3.New(TsunamiPart.position.x, TsunamiPart.position.y, TsunamiPart.position.z + .5)
            timer("MoveTsunami", 0.1)
        else
            timer("Ending", 0)
		end
	elseif name == "CreateMeteor" then
		if Meteors < 18 then
			local MeteorNumber = math.random(1,18)
			local Meteor = GetObjectByName("Meteor"..MeteorNumber)
			if Meteor.visible == false then
				Meteor.visible = true
				Meteor.physics.enabled = true
				Meteor.physics.velocity = Vector3.New(0,-100,0)
				Meteors = Meteors + 1
				timer("CreateMeteor", 1.5)
			else
				timer("CreateMeteor", 0)
			end
		else
			if RemovingMeteors < 18 then
				local MeteorsAmount = math.random(1,18)
				local Meteor2 = GetObjectByName("Meteor"..MeteorsAmount)
				if Meteor2.visible then
					Meteor2.visible = false
					Meteor2.physics.enabled = false
					Meteor2.physics.velocity = Vector3.New(0,0,0)
					local x = math.random(43.356, -124.644)
					local z = math.random(-110.5003, -252.5003)
					Meteor2.position = Vector3.New(x, 67.07936, z)
					RemovingMeteors = RemovingMeteors + 1
					timer("CreateMeteor", 0)
				else
					timer("CreateMeteor", 0)
				end
			else
				EndGame()
			end
		end
	elseif name == "Disaster" then
		ChangeMessage("<b>Playing...</b>")
		CreateDisaster(DisasterChosen)
	elseif name == "Waiting" then
		if Waiting > 0 then
			ChangeMessage("<b>Starting Disaster..</b> "..Waiting)
			Waiting = Waiting - 1
			timer("Waiting", 1)
		else
			timer("Disaster", 0)
		end
	elseif name == "Ending" then
		if Ending > 0 then
			ChangeMessage("<b>Ending..</b> "..Ending)
			Ending = Ending - 1
			timer("Ending", 1)
		else
			EndGame()
		end
	elseif name == "Regenerating" then
		for k,v in pairs(GetAllObjects()) do
			if v.name == "Map" then
				v.Remove()
			end
			if v.name == "NewMap" then
				v.visible = true
				v.cancollide = true
				v.name = "Map"
			end
		end
		Rounds = 0
		StartGame()
    end
end

function Start()
    if IsHost then
        timer("Intermission",  0)
    end
end


function OnNetMessage(player, message, data)
	if message == "Eliminated" then
		if IsHost then
        	if Survivors[player] then
            	 Survivors[player] = false
             	print(player.name .. " did not survive!")
			end
		end
	end
end

function OnDisconnect(player)
    if Survivors[player] then
        Survivors[player] = nil
    end
end