local admins = {"Lord_7302"}

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then 
        for k, i in pairs(admins) do
            if i == wildcard.username then 
                wildcard.position = Vector3.New(0,101,-200)
                this.RunOnServer(Message(wildcard))
            end 
        end
    end
end

function Message(wildcard)
    SendSystemChatToAll(wildcard.nickname .. " went to the VIP island.")
end