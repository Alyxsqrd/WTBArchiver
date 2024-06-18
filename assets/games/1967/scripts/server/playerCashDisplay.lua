
function Begin()
    while true do
        if IsValid(object.netTable["Target"]) then
            wait( .1 )
            if object.netTable["Target"] ~= "NOBODY" then
                if GetPlayerByUsername(object.netTable.Target).hasAliveCharacter then
                    object.position = GetPlayerByUsername(object.netTable.Target).character.position + Vector3.New(0,2,0)
                    object.worldText.text = (GetObjectByName(object.netTable.Owner).netTable.Money .. "$")
                end
            else
                wait(4.9)
            end
        else
            wait(5)
        end

    end
end
