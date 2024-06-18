local Player = GetLocalPlayer()
local username = Player.username


function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    this.RunOnServer("SendMSG", wildcard)
  end
end

function SendMSG(character)
  SendSystemChatToAll(username .. " has entered the Forest area")
end