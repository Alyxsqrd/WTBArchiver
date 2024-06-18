local timer = 2
local isDestroying = false


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Destroy")
    end
end

function Destroy()
    if (isDestroying) then
        return
    else
        isDestroying = true
    end
    object.renderer.color = Color.New(0.8,0.8,0.8)
    wait(timer / 5)
    object.renderer.color = Color.New(0.6,0.6,0.6)
    wait(timer / 5)
    object.renderer.color = Color.New(0.4,0.4,0.4)
    wait(timer / 5)
    object.renderer.color = Color.New(0.2,0.2,0.2)
    wait(timer / 5)
    object.renderer.color = Color.New(0,0,0)
    wait(timer / 5)
    object.collider.enabled = false
    object.renderer.visible = false
end

function Reset()
    isDestroying = false
    object.renderer.color = Color.New(1,1,1)
    object.collider.enabled = true
    object.renderer.visible = true
end