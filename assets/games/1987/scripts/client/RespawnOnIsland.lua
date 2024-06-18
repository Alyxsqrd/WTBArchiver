function OnTouchBegin(touched)
    if IsCharacter(touched)
    then
        this.RunOnServer("doTheThing")
    end
end

function doTheThing()
    GetLocalCharacter().position = GetObjectById(181).position
end