function Begin()
    while true do
        if IsValid(object.netTable["Activated"]) then
            if object.netTable.Activated == true then
                if IsValid(object.netTable.moneyAmount ) then
                    object.parent.parent.parent.netTable.Money = object.parent.parent.parent.netTable.Money+object.netTable.moneyAmount
                    branch("MoneyVisual", object.parent.GetChildByName("Block"), object.netTable.moneyAmount)
                end
            end
        end
        if IsValid(object.netTable["giveTimer"]) then
            wait(object.netTable.giveTimer)
        else
            wait(5)
        end

    end
end

function MoneyVisual(target, val)

    -- GRAB UNUSED TEXT OBJECT
    local assigned = nil
    local textObjects = GetObjectsByName("textObject")

    for i,textObject in pairs(textObjects) do
        if assigned == nil then
            if textObject.netTable["Assigned"] == false then
                textObject.netTable["Assigned"] = true
                assigned = textObject
            end
        end
    end
    
    -- PLAY ANIMATION
    if assigned ~= nil then
        assigned.position = target.position + Vector3.New(0,1,0)
        assigned.worldText.text = "+"..val.."$"

        for i = 1,30 do
            wait(0.05)
            assigned.position = assigned.position + Vector3.New(0,0.1,0)
        end

        assigned.netTable["Assigned"] = false
        assigned.position = Vector3.New(0,150,0)
        
    else
        print(target.parent.name.." is unable to find free text object")
    end
end