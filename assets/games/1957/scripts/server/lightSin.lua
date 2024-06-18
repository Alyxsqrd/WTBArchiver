function Begin()

    local shrink = true
    while true do 
        wait(.25)
        if shrink then
            object.light.range = object.light.range - 2
            if object.light.range <= 5 then
                shrink = false
            end
        else
            object.light.range = object.light.range + 1
            if object.light.range >= 15 then
                shrink = true
            end
        end
    end
end

