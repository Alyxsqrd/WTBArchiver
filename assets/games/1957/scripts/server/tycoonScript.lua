object.netTable["Owner"] = "NOBODY"
object.netTable["Money"] = 25000
object.netTable["purchasedUpgrades"] = 0

object.netTable["SeatPrice"] = 0
object.netTable["SeatUnlock"] = "Seat2"
object.netTable["SeatUnlock2"] = "Walls"
object.netTable["SeatUnlock3"] = "SnowBalls"
object.netTable["SeatMoneyAmount"] = 5
object.netTable["SeatGiveTimer"] = 5
object.netTable["SeatStarter"] = true

object.netTable["Seat2Price"] = 10
object.netTable["Seat2Unlock"] = "Seat3"
object.netTable["Seat2Unlock2"] = "Seat4"
object.netTable["Seat2Unlock3"] = "Seat5"
object.netTable["Seat2Unlock4"] = "Seat6"
object.netTable["Seat2Unlock5"] = "Seat7"
object.netTable["Seat2Unlock6"] = "Seat8"
object.netTable["Seat2Unlock7"] = "Seat9"
object.netTable["Seat2Unlock8"] = "Seat10"
object.netTable["Seat2MoneyAmount"] = 20
object.netTable["Seat2GiveTimer"] = 8
object.netTable["Seat2Starter"] = false

object.netTable["Seat3Price"] = 20
object.netTable["Seat3Unlock"] = "NONE"
object.netTable["Seat3Starter"] = false
object.netTable["Seat3MoneyAmount"] = 5
object.netTable["Seat3GiveTimer"] = 5

--[[object.netTable["Seat4Price"] = 20
object.netTable["Seat4Unlock"] = "NONE"
object.netTable["Seat4Starter"] = false
object.netTable["Seat4MoneyAmount"] = 6
object.netTable["Seat4GiveTimer"] = 6]]

object.netTable["Seat5Price"] = 20
object.netTable["Seat5Unlock"] = "NONE"
object.netTable["Seat5Starter"] = false
object.netTable["Seat5MoneyAmount"] = 7
object.netTable["Seat5GiveTimer"] = 7

object.netTable["Seat6Price"] = 20
object.netTable["Seat6Unlock"] = "NONE"
object.netTable["Seat6Starter"] = false
object.netTable["Seat6MoneyAmount"] = 8
object.netTable["Seat6GiveTimer"] = 8

object.netTable["Seat7Price"] = 20
object.netTable["Seat7Unlock"] = "NONE"
object.netTable["Seat7Starter"] = false
object.netTable["Seat7MoneyAmount"] = 9
object.netTable["Seat7GiveTimer"] = 9

object.netTable["Seat8Price"] = 20
object.netTable["Seat8Unlock"] = "NONE"
object.netTable["Seat8Starter"] = false
object.netTable["Seat8MoneyAmount"] = 10
object.netTable["Seat8GiveTimer"] = 10

object.netTable["Seat9Price"] = 20
object.netTable["Seat9Unlock"] = "NONE"
object.netTable["Seat9Starter"] = false
object.netTable["Seat9MoneyAmount"] = 11
object.netTable["Seat9GiveTimer"] = 11

object.netTable["Seat10Price"] = 20
object.netTable["Seat10Unlock"] = "NONE"
object.netTable["Seat10Starter"] = false
object.netTable["Seat10MoneyAmount"] = 12
object.netTable["Seat10GiveTimer"] = 12

object.netTable["WallsPrice"] = 20
object.netTable["WallsUnlock"] = "NONE"
object.netTable["WallsStarter"] = false

object.netTable["SnowBallsPrice"] = 30
object.netTable["SnowBallsUnlock"] = "Snowman"
object.netTable["SnowBallsStarter"] = false

object.netTable["SnowmanPrice"] = 50 
object.netTable["SnowmanUnlock"] = "AnotherSnowman"
object.netTable["SnowmanUnlock2"] = "Igloo"
object.netTable["SnowmanStarter"] = false

object.netTable["AnotherSnowmanPrice"] = 100
object.netTable["AnotherSnowmanUnlock"] = "Oven"
object.netTable["AnotherSnowmanStarter"] = false

object.netTable["OvenPrice"] = 150
object.netTable["OvenUnlock"] = "GingerbreadMan"
object.netTable["OvenUnlock2"] = "Belt"
object.netTable["OvenStarter"] = false

object.netTable["BeltPrice"] = 150
object.netTable["BeltUnlock"] = "Presents"
object.netTable["BeltStarter"] = false

object.netTable["PresentsPrice"] = 150
object.netTable["PresentsUnlock"] = "MoreSnowmen"
object.netTable["PresentsStarter"] = false

object.netTable["MoreSnowmenPrice"] = 150
object.netTable["MoreSnowmenUnlock"] = "MorePresents"
object.netTable["MoreSnowmenStarter"] = false

object.netTable["MorePresentsPrice"] = 150
object.netTable["MorePresentsUnlock"] = "NONE"
object.netTable["MorePresentsStarter"] = false

object.netTable["GingerbreadManPrice"] =250
object.netTable["GingerbreadManUnlock"] = "Candycane"
object.netTable["GingerbreadManStarter"] = false

object.netTable["CandycanePrice"] =250
object.netTable["CandycaneUnlock"] = "NONE"
object.netTable["CandycaneStarter"] = false

object.netTable["IglooPrice"] = 50
object.netTable["IglooUnlock"] = "NONE"
object.netTable["IglooStarter"] = false

function Begin()

    

    print("INIT TYCOON VARIABLES")
    print(object.name.." OWNER : "..object.netTable.Owner)
    print(object.name.." MONEY : "..object.netTable.Money)
    print(object.name.." PURCHASED UPGRADES : "..object.netTable.purchasedUpgrades)

    print("INIT TYCOON BUTTONS")

    local buttons = object.GetChildByName("Buttons").GetDirectChildren()
    for i = 1,#buttons do

        local varName = buttons[i].name.."Price"

        buttons[i].renderer.color = Color.New(0.3, .55, 0.3, 1.0)

        if IsValid(object.netTable[varName]) then
            buttons[i].netTable["Price"] = object.netTable[varName]
        else
            buttons[i].netTable["Price"] = 50
            print("COULD NOT FIND PRICE FOR "..buttons[i].name.. " | DEFAULT TO 50")
        end

        buttons[i].netTable["Purchased"] = false

        if not buttons[i].GetChildByName("TextHolder") then
            local txtHolder = CreateEmptyObject()
            txtHolder.parent = buttons[i]
            txtHolder.position = Vector3.New(0,1.5,0)
            txtHolder.name = "TextHolder"

            local wrldText = txtHolder.AddComponent("worldText")
            --local varName = buttons[i].name.."Price"
            txtHolder.worldText.text = buttons[i].name .. " : "..buttons[i].netTable["Price"].."$"
            txtHolder.worldText.size = 4
            txtHolder.worldText.outlineWidth = 0.25
            txtHolder.worldText.font = "Roboto"
            txtHolder.worldText.hideAtDistance = true
            txtHolder.worldText.hiddenDistance = 20

        end

    end

    resetTycoon()

end

function Purchase(type, model, price)
    if type == "Unlock" then
        if object.netTable.Money >= price then

            object.netTable.Money = object.netTable.Money - price
            object.netTable.purchasedUpgrades = (object.netTable.purchasedUpgrades + 1)
            model.netTable.Purchased = true

            makeVisible(object.GetChildByName("Models").GetChildByName(model.name))
            branch("buttonLookCool", object.GetChildByName("Buttons").GetChildByName(model.name), 1)
            
            local varName = model.name.."Unlock"

            if IsValid(object.netTable[varName]) then
                --proceed as normal
            else
                --make unlock variable to avoid failure
                print("COULD NOT FIND UNLOCK VARIABLE".. " | DEFAULT TO NONE")
                object.netTable[varName] = "NONE"
            end

            if object.netTable[varName] ~= "NONE" then
                branch("buttonLookCool", object.GetChildByName("Buttons").GetChildByName(object.netTable[varName]), 2)

                local moreUnlocks = true
                local counter = 1
                while moreUnlocks do
                    counter = counter+1
                    local varName2 = model.name.."Unlock"..counter

                    if IsValid(object.netTable[varName2]) and counter < 10 then
                        branch("buttonLookCool", object.GetChildByName("Buttons").GetChildByName(object.netTable[varName2]), 2)
                    else
                        moreUnlocks = false
                    end
                end
            end

            if object.GetChildByName("Models").GetChildByName(model.name).GetChildByName("moneyMaker") then
                object.GetChildByName("Models").GetChildByName(model.name).GetChildByName("moneyMaker").netTable.Activated = true
            end

            print("PURCHASING")
            print("MODEL : "..model.name)
            print("PRICE : " ..price)
        end
    else
        print("Not Functional")
    end
end

function resetTycoon()
    --make everything invisille and inactive and untouchable
    --reset all variables needed

    local models = object.GetChildByName("Models").GetDirectChildren()
    for i,v in pairs(models) do
        doChildren(v, v.name)
    end

    local buttons = object.GetChildByName("Buttons").GetDirectChildren()
    for i,v in pairs(buttons) do
        buttonSetup(v, v.name)
    end
end

function buttonSetup(passedObject, buttonName)
    local varName = passedObject.name .. "Starter"

    if IsValid(object.netTable[varName]) then else
        --if no starter variable, make one
        print("COULD NOT FIND STARTER FOR "..buttonName.." | DEFAULT TO TRUE")
        object.netTable[varName] = true
    end

    if object.netTable[varName] == true then

    else
        passedObject.renderer.visible = false
        passedObject.collider.enabled = false
        passedObject.GetChildByName("TextHolder").worldText.size = 0
    end
end

function doChildren(passedObject, modelName)

    if passedObject.name == "moneyMaker" then
        local varName1 = modelName.."MoneyAmount"

        if IsValid(object.netTable[varName1]) then else
            object.netTable[varName1] = 10
            print("COULD NOT FIND MONEY VALUE FOR ".. modelName.. " | DEFAULT TO 10")
        end

        passedObject.netTable.moneyAmount = object.netTable[varName1]

        local varName2 = modelName.."GiveTimer"

        if IsValid(object.netTable[varName2]) then else
            object.netTable[varName2] = 10
            print("COULD NOT FIND GIVE TIMER FOR ".. modelName.. " | DEFAULT TO 10")
        end

        passedObject.netTable.giveTimer = object.netTable[varName2]
        passedObject.netTable.Activated = false
    end

    if passedObject.renderer then
        passedObject.renderer.visible = false
    end

    if passedObject.collider then
        passedObject.collider.enabled = false
    end

    if passedObject.light then
        passedObject.light.enabled = false
    end
    
    local kids = passedObject.GetDirectChildren()

    if #kids >= 1 then
        for i,v in pairs(kids) do
            doChildren(v,modelName)
        end
    end
end

function makeVisible(passedObject, spd)
    local parts = passedObject.GetDirectChildren()

    for i,v in pairs(parts) do
        branch("descentMove", parts[i], math.log(#parts,1.4))
    end
end

function buttonLookCool(passedObject, funcType)
    if funcType == 1 then
        local baseTextSize = passedObject.GetChildByName("TextHolder").GetComponent("worldText").size

        for k = 1,10 do
            wait(.05)
            passedObject.GetChildByName("TextHolder").GetComponent("worldText").size = baseTextSize - (baseTextSize*k/10)
            passedObject.size = passedObject.size - Vector3.New(.1,0,.1)
        end
        --passedObject.GetChildByName("TextHolder").GetComponent("worldText").enabled = false
        --passedObject.GetChildByName("TextHolder").GetComponent("worldText").size = baseTextSize
        passedObject.size = Vector3.New(1,.1,1)
        passedObject.renderer.visible = false
        passedObject.collider.enabled = false
    else
        local baseTextSize = 5

        passedObject.size = Vector3.New(0,.1,0)

        for k = 1,10 do
            wait(.025)
            passedObject.GetChildByName("TextHolder").GetComponent("worldText").size = (baseTextSize*k/10)
            passedObject.size = passedObject.size + Vector3.New(.1,0,.1)
        end

        passedObject.GetChildByName("TextHolder").GetComponent("worldText").size = baseTextSize
        passedObject.size = Vector3.New(1,.1,1)
        passedObject.renderer.visible = true
        passedObject.collider.enabled = true
    end
end

function descentMove(passedBrick, spd)
    local brick = passedBrick
    local orig = brick.position
    local movespeed = math.ceil(3/spd * 15)
    for j = 1,movespeed do
        wait( .0167 )

        if brick.renderer then
        brick.renderer.visible = true
        end
        
        if brick.collider then
            brick.collider.enabled = true
        end

        if brick.light then
            brick.light.enabled = true
        end
        --math.log( 2.7-(j/20*1.7), 2.71)
        brick.position = Vector3.Lerp(orig, orig + Vector3.New(0,3,0),  math.log( 10-(j/movespeed*9), 10))
    end
end

function OnNetMessage(msgData)
    local user = msgData[4]
    if user == object.netTable.Owner then
        if GetObjectById(msgData[3]).netTable.Purchased == false then
            local msgType = msgData[1]
            local type = msgData[2]
            local model = nil
            local price = nil

            local debounce = false
            print(IsValid(GetObjectById(msgData[3])))
            if IsValid(GetObjectById(msgData[3])) then
                model = GetObjectById(msgData[3])
            else
                print("ERROR ON NET MESSAGE : OBJECT NOT FOUND")
                debounce = true
            end

            if IsValid(GetObjectById(msgData[3]).netTable.Price) then
                price = GetObjectById(msgData[3]).netTable.Price
            else
                print("ERROR ON NET MESSAGE : NETTABLE NOT FOUND")
                debounce = true
            end
            
            if not debounce then
                if msgType == "buttonPressed" then
                    Purchase(type,model,price)
                end
            end
        end
    end
end