object.netTable["Money"] = 0

local debounce = true

function InitializeFunction()
    local money = string.sub(object.name, 10)
    object.netTable.Money = money
    object.renderer.color = Color.New(100/255, 220/255, 100/255)
end

function OnTouchBegin(touched)
    if debounce == true then
        debounce = false
        object.renderer.color = Color.New(220/255, 50/255, 50/255)
        if GetObjectByName("TycoonEntity1") then

            if GetObjectByName("TycoonEntity1").netTable.Owner == touched.username then

                GetObjectByName("TycoonEntity1").netTable.Money = GetObjectByName("TycoonEntity1").netTable.Money + object.netTable.Money
                GetObjectByName("Tycoon1MoneyDisplay").worldText.text = "Money: ".. GetObjectByName("TycoonEntity1").netTable.Money .."$"
            end    
        end
        if GetObjectByName("TycoonEntity2") then

            if GetObjectByName("TycoonEntity2").netTable.Owner == touched.username then

                GetObjectByName("TycoonEntity2").netTable.Money = GetObjectByName("TycoonEntity2").netTable.Money + object.netTable.Money
                GetObjectByName("Tycoon2MoneyDisplay").worldText.text = "Money: ".. GetObjectByName("TycoonEntity2").netTable.Money .."$"
            end     
        end
        if GetObjectByName("TycoonEntity3") then

            if GetObjectByName("TycoonEntity3").netTable.Owner == touched.username then

                GetObjectByName("TycoonEntity3").netTable.Money = GetObjectByName("TycoonEntity3").netTable.Money + object.netTable.Money
                GetObjectByName("Tycoon3MoneyDisplay").worldText.text = "Money: ".. GetObjectByName("TycoonEntity3").netTable.Money .."$"
            end    
        end
        touched.position = Vector3.New(0,10,0)
        wait(1)
        debounce = true
        object.renderer.color = Color.New(100/255, 220/255, 100/255)
    end
end