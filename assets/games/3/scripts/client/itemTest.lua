

function OnItemMouseDown()
    print("mouse down! " .. Time.time)
end

function Tick()
    if Input.KeyPressed("F") then
        print("F pressed, requesting to be killed")
        this.RunOnServer("KillMe", GetLocalCharacter())
    end
end

function KillMe(char)
    print("as you wish.. killing")
    char.Kill()
    print("killed")
end