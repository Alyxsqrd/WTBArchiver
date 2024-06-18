function OnTouchBegin(toucher)
    if IsCharacter(toucher) then
        PlayOneShotLocal(25,0.3,3)
        DeleteObject(object)
    end
end