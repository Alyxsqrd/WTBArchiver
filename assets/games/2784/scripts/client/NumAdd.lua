function OnInteracted()
    print(object.name)
    local Value = object.name
    local Num = object.parent.GetChildByName("Number").worldText.text
    if object.name != "0" then
        object.parent.GetChildByName("Number").worldText.text = Num + Value
    else
        object.parent.GetChildByName("Number").worldText.text = "0"
    end
end