

function OnTouchBegin(wildcard)
    printScreen("touch", 3)
    if IsCharacter(wildcard) then
        printScreen("it's a char", 3)
        this.RunOnServer("Remove", wildcard)
    end
end

function Remove(char)
    printScreen("ran on server", 3)
    if char.player.hasCheckpoint then
        printScreen("removing checkpoint from player", 3, Color.green)
        char.player.RemoveCheckpoint()
    else
        printScreen("player has no checkpoint yet", 3, Color.red)
    end
end