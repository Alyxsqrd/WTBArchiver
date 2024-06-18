
local isFlying = LocalPlayer().table.isFlying
local flySpeed = 1

local function FlyToggle(switch)
    if switch == 1 or not isFlying then
        LocalPlayer().frozen = true

        isFlying = true

    elseif switch == 0 or isFlying then
        LocalPlayer().frozen = false
        LocalPlayer().angles = newVector3(0, LocalPlayer().angles.y, LocalPlayer().angles.z)

        isFlying = false
    end
end

function Update()
    if InputPressed("1") then
        FlyToggle()
    end

    if isFlying then
        LocalPlayer().angles = LocalPlayer().viewAngles

        if InputHeld("w") then
            LocalPlayer().position = LocalPlayer().position + (LocalPlayer().forward * flySpeed)
        end

        if InputHeld("s") then
            LocalPlayer().position = LocalPlayer().position - (LocalPlayer().forward * flySpeed)
        end

        if InputHeld("a") then
            LocalPlayer().position = LocalPlayer().position - (LocalPlayer().right * flySpeed)
        end

        if InputHeld("d") then
            LocalPlayer().position = LocalPlayer().position + (LocalPlayer().right * flySpeed)
        end

        if InputPressed("left shift") then
            flySpeed = 0.4
        end

        if InputReleased("left shift") then
            flySpeed = 0.1
        end
    end
end

