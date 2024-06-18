local canTeleport = false

function Begin()
  print("First string is working!")
  wait(4)
  print("Second string is working! Wait 1 is ahead and in 1 second canTeleport should be turned to true. Then press E.")
  wait(1)
  canTeleport = true
end

function OnKeyPress(key)
  if canTeleport and key == "E" then
    teleportPlayer()
  end
end

function teleportPlayer()
  character.position = Vector3.New(1, 1000, 1)
end