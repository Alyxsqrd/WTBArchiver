print("Rocket script")

local blastRadius = 3
local blastPressure = 300

function OnTouchBegin(touched)
    if touched.id ~= GetLocalPlayer().id and touched.name ~= "Rocket Launcher" then
        print("Hit")
        this.RunOnServer("RocketHit")
    end
end

function RocketHit()
    local hitPos = object.position+object.forwardDirection*0.2
    object.Delete()
    PlayOneShotAt(7, 1.0, 1.0, hitPos, 10.0)

    local hitObjects = GetObjectsInSphere(hitPos, blastRadius)

    for k, obj in pairs(hitObjects) do
        if obj.physics then
            local dir = Vector3.Direction(hitPos, obj.position)
            obj.physics.AddExplosionForce(hitPos, blastPressure/100, blastRadius)
        end
    end
end