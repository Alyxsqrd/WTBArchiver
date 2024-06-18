
function Begin()

    if isHost then 

        while true do 
            wait(.5)
            object.worldText.enabled = true
            wait(.5)
            object.worldText.enabled = false
            wait(.5)
        end 
    end
end
