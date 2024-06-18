local revealed = false


function Begin()
    Event.Bind(this, "CompleteRevealLampPuzzle")
end

function OnInvisible()
    if revealed then
        object.renderer.transparency = 100
        object.collider.enabled = false
    end

    local rand = Random.NumberRounded(0, 1)
    if (rand == 0) then
        object.localTable["inv"] = false
        object.renderer.transparency = 100
    else
        object.localTable["inv"] = true
        object.renderer.transparency = 0
    end
end

function CompleteRevealLampPuzzle()
    object.renderer.transparency = 100
    object.collider.enabled = false
end