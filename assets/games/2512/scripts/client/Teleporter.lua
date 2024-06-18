--function OnInteracted(interactor)
    --this.RunOnServer("Teleport", interactor)
    --end
  
function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Teleport", wildcard)
    end
end
  
function Teleport(character)
    character.position = GetObjectByName(this.name + "End").position 
    -- or
    --character.position = Vector3.New(0, 100, 0)
end