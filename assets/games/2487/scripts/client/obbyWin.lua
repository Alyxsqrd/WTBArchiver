function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        if wildcard.forceField == false then
            this.RunOnServer(Message(wildcard))
        end
    end 
end 

function Message(wildcard)
    SendSystemChatToAll(wildcard.username .. " completed the obby!")
end