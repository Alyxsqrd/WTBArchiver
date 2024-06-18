function OnTouchBegin(touched)
    if(IsCharacter(touched))then
        touched.Kill()
    end
end