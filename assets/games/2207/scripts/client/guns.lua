

function Tick()
    if Input.LeftMousePressed() then
        Shoot()
    end
end

function Shoot()
    local character = GetLocalCharacter()
    local hit = RayCast(character.position, Vector3.Direction(character.position, Input.mouseWorldPosition), 100)

    if IsCharacter(hit.hitWildcard) then
        this.RunOnServer("Damage", hit.hitWildcard)
    end

    this.RunOnServer("MakeBullet", hit.startPosition, hit.endPosition)
end

function Damage(character)
    character.Damage(20)
end

function MakeBullet(startingPosition, endingPosition)
    local bullet = CreateLocalEmptyObject()
    waitTick(1)
    bullet.size = Vector3.New(0.1, 0.1, Vector3.Distance(startingPosition, endingPosition))
    bullet.rotation = Vector3.LookRotation(Vector3.Direction(endingPosition, startingPosition), Vector3.New(0,1,0))
    bullet.position = Vector3.Middle(startingPosition, endingPosition)

    bullet.AddComponent("renderer")
    bullet.renderer.color = Color.New(1,1,0)

    wait(0.2)

    bullet.Delete()
end