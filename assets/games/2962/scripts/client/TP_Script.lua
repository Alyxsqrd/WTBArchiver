function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        this.RunOnServer("TeleportOnServer", wildcard)
    end
end 

function TeleportOnServer(wildcard)
  wildcard.position = GetObjectByName("BlockB").position
end