

function OnMouseClick()
    this.RunOnServer("Switch")
end

function Switch()
    local lightObject = GetObjectByName("My Light")
    local light = lightObject.light -- get the light component on this object

    if light.enabled then
        light.enabled = false
    else
        light.enabled = true
    end
end