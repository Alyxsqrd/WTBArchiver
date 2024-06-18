function OnTouchBegin(touched)
    if(IsCharacter(touched)) then
        touched.speed = 1
    end
end