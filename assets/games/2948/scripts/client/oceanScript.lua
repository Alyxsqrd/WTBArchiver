function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        this.RunOnServer("TeleportOnServer", wildcard)
    end
end 

function TeleportOnServer(wildcard)
  wildcard.RemoveItem()
  wildcard.position = GetObjectByName("RespawnPoint").position
end