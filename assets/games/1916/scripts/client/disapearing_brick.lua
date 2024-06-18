

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("disapear", wildcard)
    end
end

function disapear(IsBlockRenderer)
    while true do 
    object.collider.enabled = false
    wait(.5)
    object.collider.enabled = true
    end 
    

end