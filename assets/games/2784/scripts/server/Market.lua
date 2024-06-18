function Begin()
    AddPrevPrices()
    AddTrends()
    Market()
end

local AllStocks = object.GetChildByName("Stocks").GetAllChildren()
print(AllStocks)

function AddPrevPrices()
    for i,v in pairs(AllStocks) do
        local NewEmptyObject = CreateEmptyObject()
        NewEmptyObject.AddComponent("worldText")
        NewEmptyObject.worldText.text = v.worldText.text
        NewEmptyObject.name = "PrevPrice"
        NewEmptyObject.parent = v
        NewEmptyObject.worldText.faceCamera = false
        NewEmptyObject.worldText.size = 6
        NewEmptyObject.MoveTo(v.position + Vector3.New(0,1,0), 0)
    end
end

function AddTrends()
    for i,v in pairs(AllStocks) do
        local NewEmptyObject = CreateEmptyObject()
        NewEmptyObject.AddComponent("worldText")
        NewEmptyObject.worldText.text = 0
        NewEmptyObject.name = "Trend"
        NewEmptyObject.parent = v
    end
end

function Market()
    while true do
        wait(1)
        
        for i,v in pairs(AllStocks) do
            local Price = v.worldText.text
            local PrevPrice = v.GetChildByName("PrevPrice").worldText.text
            local Trend = v.GetChildByName("Trend").worldText.text
            v.GetChildByName("PrevPrice").worldText.text = Price
            v.worldText.text = Math.Round(Price * (Random.Number(0.99,1.01) + Trend))
            local Change = Price - PrevPrice
            --print(v.name .. " " .. Change .." (" .. Price .. " - " .. PrevPrice .. ")")
            if Change >= 0 then
                v.worldText.color = Color.New(1,255,1)
            else
                v.worldText.color = Color.New(255,1,1)
            end
        end
    end
end