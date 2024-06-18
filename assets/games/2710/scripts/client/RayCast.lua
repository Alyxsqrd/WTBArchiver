local ray = nil
local lastHit = {
    ["object"] = nil,
    ["color"] = nil
}

function OnPlayerJoin(player)
    ray = CreatePremade("Ray")
end

function Tick()
    local char = GetLocalCharacter()
    local rayStart = char.position + NewVec3(0, 1.4, 0)
    local rayEnd = Input.mouseWorldPosition
    local rayDir = Vector3.Direction(rayStart, rayEnd)
    local rayMag = (rayStart-rayEnd).Magnitude()
    local rayMid = rayStart + (rayDir*rayMag/2)

    ray.RotateTowards(rayEnd, 0)
    ray.size = NewVec3(0.1, 0.1, rayMag)
    ray.position = rayMid

    local hitData = LineCast(rayStart, rayEnd)
    local hitThing = hitData.hitWildcard

    if Input.LeftMousePressed() and hitThing.renderer.color then
        if lastHit["object"] then
            if lastHit["object"].id ~= hitThing.id then
                lastHit["object"].renderer.color = lastHit["color"]
                lastHit["object"] = hitThing
                lastHit["color"] = hitThing.renderer.color
                hitThing.renderer.color = Color.red
            end
        else
            lastHit["object"] = hitThing
            lastHit["color"] = hitThing.renderer.color
            hitThing.renderer.color = Color.red
        end
    end
end

function NewVec3(x, y, z)
    return Vector3.New(x, y, z)
end