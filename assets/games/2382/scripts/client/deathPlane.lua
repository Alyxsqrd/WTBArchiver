function OnTouchBegin(touched)
    if IsCharacter(touched) then
        local localChar = GetLocalCharacter()
        if touched.netId == localChar.netId then
            if touched.health == 1 then
                Event.BroadcastToServer("KillCharacter",localChar.netId)
            else
                Event.BroadcastToServer("murder",localChar.netId)
            end
        end
    end
end