local timer = 4
local isDestroying = false
local isLava = false


function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        this.RunOnServer("Activate", GetLocalCharacter())
    end
end

function Activate(character)
    if (isLava) then
        character.Damage(15)
        return
    end

    if (isDestroying == false) then
        isDestroying = true

        object.renderer.color = Color.New(0.5,0.4,0.4)
        wait(timer / 8)
        object.renderer.color = Color.New(0.5,0.3,0.3)
        wait(timer / 8)
        object.renderer.color = Color.New(0.5,0.2,0.2)
        wait(timer / 8)
        object.renderer.color = Color.New(0.5,0.1,0.1)
        wait(timer / 8)

        isLava = true
        object.renderer.color = Color.New(0.5,0,0)
        wait(timer / 2)

        object.collider.enabled = false
        object.renderer.visible = false
    end
end

function Reset()
    isDestroying = false
    isLava = false
    object.renderer.color = Color.New(0.5,0.5,0.5)
    object.collider.enabled = true
    object.renderer.visible = true
end