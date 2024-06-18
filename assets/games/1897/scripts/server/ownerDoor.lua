local tycoonid = 1
function InitializeFunction()
    local index = string.sub(string.find(object.name, "Tycoon"),1) + 6
    if string.find(object.name, "Tycoon") ~= nil then
        tycoonid = string.sub(object.name, index, index)
        print(object.name .." assigned tycoonid "..tycoonid)
    else
        print('invalid Object')
    end
end



function OnTouchBegin(touched)
    print(touched.player.username)
    local tycoonName = "TycoonEntity"..tycoonid
    local tycoon = GetObjectByName(tycoonName)
    if tycoon.netTable.Owner == "" then
        if GetObjectByName("TycoonEntity1") then
            if GetObjectByName("TycoonEntity1").netTable.Owner == touched.player.username then
                return nil
            end
        end
        if GetObjectByName("TycoonEntity2") then
            if GetObjectByName("TycoonEntity2").netTable.Owner == touched.player.username then
                return nil
            end
        end
        tycoon.netTable.Owner = touched.player.username
        object.renderer.visible = false
        object.collider.enabled = false
        GetObjectByName("Tycoon"..tycoonid.."OwnerDisplay").worldText.text = touched.player.username.."'s Tycoon"
        GetObjectByName("Tycoon"..tycoonid.."MoneyDisplay").worldText.enabled = true
    end
end
