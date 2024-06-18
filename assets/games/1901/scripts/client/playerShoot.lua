
--[[
function Begin()
    while true do 
        wait(.05)
        if object.netTable.Owner ~= "" then
            local pressedmaybe = Input.LeftMousePressed()
            print(pressedmaybe)
        end
    end
end]]