
local objects = GetAllObjects()
local activated = false

function Tick()
    if not activated then
        activated = true
        for i = 1,#objects do
            if objects[i].name == "DemoModel" then
                --do nothing
            else
                local scripts = objects[i].GetAllScripts()
                for k = 1,#scripts do
                    scripts[k].Run("InitializeFunction")
                end
             end
        end
    end
end

function InitializeFunction()
    print("Scripts Initialized")
end