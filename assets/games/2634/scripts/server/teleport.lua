function OnTouchBegin(touched)
    outPos = GetObjectByName(object.name.."Out").position
    if(IsCharacter(touched)) then
        touched.position = outPos
    end
end