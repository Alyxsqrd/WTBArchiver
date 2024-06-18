local keepGoing = true


function Begin()
    branch("Lightning")

    Event.Bind(this, "StopLightning")
    Event.Bind(this, "StartLightning")
end

function StopLightning()
    keepGoing = false
end

function StartLightning()
    keepGoing = true
end

function Lightning()
    while true do
        if keepGoing then
            Short()
            Long()
            Short()
            Pause()
            Short()
            Short()
            Long()
            Pause()
            Long()
            Long()
            Short()
            Pause()
        else
            wait(10)
        end
    end
end

function Short()
    Event.Broadcast("LightningOn")
    wait(0.5)
    Event.Broadcast("LightningOff")
    wait(0.5)
end

function Long()
    Event.Broadcast("LightningOn")
    wait(1.15)
    Event.Broadcast("LightningOff")
    wait(0.5)
end

function Pause()
    wait(2)
end