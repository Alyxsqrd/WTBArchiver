local casings = {}

Event.Bind(this, "NewCasing")

function NewCasing(casing)
    local curTime = Time.time*1000
    local casingInfo = {
        "casing" = casing,
        "created" = curTime,
        "despawning" = false
    }

    table.insert(casings, casingInfo)
end

function PhysicsTick()
    for k, v in pairs(casings) do

    end
end