function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        wildcard.position = Vector3.New(0,101,200)
        this.RunOnServer(Message(wildcard))
    end
end

function Message(wildcard)
    SendSystemChatToAll(wildcard.nickname .. " went to the island.")
end