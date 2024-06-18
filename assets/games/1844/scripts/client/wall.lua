

function Begin()
    Event.Bind(this, "StartMovingWall")
    Event.Bind(this, "ChangeWallDesign")
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        Event.Broadcast("KillCharacter", wildcard)
    end
end

function StartMovingWall(moveTime)
    object.position = GetObjectByName("WallSpawn").position
    object.MoveTo(object.position + Vector3.New(0, 0, -25), moveTime)
end

function ChangeWallDesign(designName)
    object.voxelRenderer.design = designName
    object.collider.enabled = false
    waitTick(1)
    object.collider.enabled = true
end