function OnTouchBegin(toucher)
    if IsCharacter(toucher) then
        
        if toucher.alive then
            toucher.Kill()
        end
        --SendSystemChatToAll('touched a player)')
    end
end