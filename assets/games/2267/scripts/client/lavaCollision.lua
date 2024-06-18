function OnTouchBegin(touched)
    if IsCharacter(touched) then
        local localChar = GetLocalCharacter()
        if touched.username == localChar.username then
            if touched.forceField == false then
                if touched.health == 1 then
                    Event.BroadcastToServer("KillCharacter",localChar.netId)
                else
                    Event.BroadcastToServer("murder",localChar.netId)
                end
            end
        end
    end
end