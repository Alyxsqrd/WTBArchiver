function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        wildcard.position = Vector3.New(0,1,-10)
        this.RunOnServer(Message(wildcard))
    end
end

function Message(wildcard)
    SendSystemChatToAll(wildcard.nickname .. " came back to mainland.")
end