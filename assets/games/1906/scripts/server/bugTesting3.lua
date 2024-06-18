

local list = GetAllObjects()
local triggered = false

function Tick()
    if not triggered then
        triggered = true
        for i = 1,#list do
            if list[i] ~= object then
                local scripts = list[i].GetAllScripts()
                for k = 1,#scripts do 
                    print("Run 1")
                    print(scripts[k])
                    scripts[k].Run("SetupFunc")
                end
            end
        end
    end
end