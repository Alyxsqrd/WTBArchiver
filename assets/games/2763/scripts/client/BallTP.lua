function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    wait(0.1)
    this.RunOnServer("Teleport", wildcard)
  end
end

function Teleport(character)
  character.position = GetObjectByName("Spawnpoint").position
end