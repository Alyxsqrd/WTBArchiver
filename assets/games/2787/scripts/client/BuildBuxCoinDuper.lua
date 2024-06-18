function Begin()
  print("first debug print")
end

function spawnRain()
  local rainDrop = GetObjectByName("RainDroplet").Duplicate()
  local xPos = math.random(-49.5, 49.5)
  local yPos = 30
  local zPos = math.random(-49.5, 49.5)	
  rainDrop.position = Vector3.New(xPos, yPos, zPos)
end

function OnTouchBegin(rainDrop)
   rainDrop.Delete()
end

function Tick()
  this.RunOnServer("spawnRain")
end