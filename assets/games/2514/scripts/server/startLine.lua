function OnTouchBegin(touched)
    if(IsCharacter(touched)) then
        touched.speed = 2
    end
end