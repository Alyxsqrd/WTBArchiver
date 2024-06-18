

function Begin()
    if isHost then
        object.netTable["ready"] = true
        OnNetTableUpdated()
    end
end

function OnNetTableUpdated()
    if object.netTable["ready"] then
        object.renderer.color = Color.ColorFromHex("#43c66f") -- green
    else
        object.renderer.color = Color.ColorFromHex("#c61d26") -- red
    end
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        if wildcard.player.isHost then
            if object.netTable["ready"] then
                Launch()
                branch("Cooldown")
            end
        end
    end
end

function Cooldown()
    object.netTable["ready"] = false
    wait(2)
    object.netTable["ready"] = true
end

function Launch()
    local firework = DuplicateObject(GetObjectByName("Firework"))
    firework.position = object.position + Vector3.New(0, 5, 0)
    local explosionColor = Random.Color()
    firework.renderer.color = explosionColor
    firework.physics.enabled = true
    firework.physics.AddForce(Vector3.New(0, Random.Number(17.5, 25), 0))
    branch("ExplodeFirework", firework, explosionColor)
end

function ExplodeFirework(firework, explosionColor)
    wait(Random.Number(0.75, 1.5))
    local toggle = false
    for i = 1, Random.Number(15, 25) do
        if toggle then
            waitTick(1)
            toggle = false
        else
            toggle = true
        end
        local debris = DuplicateObject(GetObjectByName("Debris"))
        local scale = Random.Number(0.4, 1.0)
        debris.size = Vector3.New(scale, scale, scale)
        debris.position = firework.position + Random.OnSphere(1)
        debris.renderer.color = explosionColor
        debris.physics.enabled = true
        local debrisScript = debris.GetScriptByName("debris")
        if IsValid(debrisScript) then
            debrisScript.Run("Explode", firework.position)
        end
    end
    DeleteObject(firework)
end