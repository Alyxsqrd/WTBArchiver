local toggled = false

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        if toggled == false then
            toggled = true
            this.RunOnServer("Open", wildcard)
        end
    end
end

function Open(character)
    GetPlayerByUsername(character.username).SendSystemChat("Button On, 30 Seconds")
    object.parent.GetChildByName("Door").blockRenderer.transparency = 75
    object.parent.GetChildByName("Door").collider.enabled = false
    wait(30)
    object.parent.GetChildByName("Door").blockRenderer.transparency = 0
    object.parent.GetChildByName("Door").collider.enabled = true
    toggled = false
end