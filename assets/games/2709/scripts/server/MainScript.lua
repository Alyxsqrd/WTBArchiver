local Status = GetObjectByName("Status")

local murder
local sheriff

function Begin()
    while true do
        for i = 10, 0, -1 do
            Status.worldText.text = "Intermission: "..i
            wait(1)
        end

        murder = Random.Player()
        repeat sheriff = Random.Player() wait(0.1) until sheriff ~= murder

        print(murder.. " | "..sheriff)
        wait(1)
    end
end