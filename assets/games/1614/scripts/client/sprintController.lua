local SPRINT_RUNNING = 1
local SPRINT_STOPPED = 0
local SPRINT_KEYBIND = "left shift"

local state = SPRINT_STOPPED

local lastState
local isStateStill = false
function Update()
    isStateStill = (lastState == state)

    if InputPressed(SPRINT_KEYBIND) then
        state = SPRINT_RUNNING
    else if InputReleased(SPRINT_KEYBIND) then
        state = SPRINT_STOPPED
    end

    if not isStateStill then
        NetworkSendToHost("SPRINT", {
            state = state,
        })
    end

    lastState = state
end
