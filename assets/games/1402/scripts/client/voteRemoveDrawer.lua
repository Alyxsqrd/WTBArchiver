


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("SendVote", wildcard.player)
    end
end

function SendVote(player)
    GetObjectByName("GameManager").GetScriptByName("gameManager").Run("VoteRemoveDrawer", player)
end