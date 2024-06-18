function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        this.RunOnServer("TeleportOnServer", wildcard)
    end
end 

function TeleportOnServer(wildcard)
  wildcard.position = GetObjectByName("return3").position
end