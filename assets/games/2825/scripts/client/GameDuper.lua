local spawnRainEnabled = false  -- Flag to control rain spawning
local cooldownDuration = 10  -- Initial cooldown duration in seconds
local cooldownDecreaseRate = 0.3  -- Rate at which cooldown decreases per second
local rainSpawnCount = 0  -- Counter for recorded rain spawns

function spawnRain()
   local rainDrop = GetObjectByName("LitterDupe").Duplicate()
   local xPos = math.random(-24, 24)
   local yPos = 15
   local zPos = math.random(-24, 24)
   local xRot = math.random(0, 360)
   local yRot = math.random(0, 360)
   local zRot = math.random(0, 360)
   rainDrop.position = Vector3.New(xPos, yPos, zPos)
   rainDrop.rotation = Vector3.New(xRot, yRot, zRot)
   object.sound.Play()
end

function Begin()
   print("first debug print")
   while true do
      wait(cooldownDuration)
      if spawnRainEnabled then
         this.RunOnServer("spawnRain")
         if rainSpawnCount >= 6 then
		print("rain count 6")
 	      StopRainSpawning()
            cooldownDuration = 12
		wait(1)
            local character = GetLocalCharacter()
   	      this.RunOnServer("KillCharacter", character)
    	      wait(1)
            rainSpawnCount = 0
            GetObjectById(56).GetScriptByName("RemoveItemTrash").RunOnServer("GameEnd", character)
            GetObjectById(1).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)
            GetObjectById(44).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)   
		GetObjectById(41).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)   
		GetObjectById(205).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)  
		GetObjectById(208).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)   
		GetObjectById(38).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)  
		GetObjectById(47).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)
		GetObjectById(214).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)   
		GetObjectById(217).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)    
		GetObjectById(223).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character) 
		GetObjectById(220).GetScriptByName("ClearTrash").RunOnServer("GameEnd", character)                 
         end
      end
      cooldownDuration = math.max(cooldownDuration - cooldownDecreaseRate, 3)
   end
end

-- Function to start the rain spawning
function StartRainSpawning()
   spawnRainEnabled = true
   print("Rain spawning started")
end

-- Function to stop the rain spawning
function StopRainSpawning()
   spawnRainEnabled = false
   print("Rain spawning stopped")
end

-- Function to record a rain spawn
function RecordRainSpawn()
   rainSpawnCount = rainSpawnCount + 1
end


-- Function to unrecord a rain spawn
function UnrecordRainSpawn()
   rainSpawnCount = math.max(rainSpawnCount - 1, 0)
end

function KillCharacter(character)
   print("killed character")
   character.position = Vector3.New(1, -1000, 1)
end