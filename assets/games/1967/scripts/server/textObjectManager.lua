function Begin()
    
    textObjects = GetObjectsByName("textObject")
    for i,textObject in pairs(textObjects) do
        textObject.worldText.text = "+0$"
        textObject.worldText.font = "Roboto"
        textObject.worldText.size = 5
        textObject.worldText.hideAtDistance = true
        textObject.worldText.hiddenDistance = 20
        textObject.worldText.outlineWidth = 0.25
        textObject.netTable["Assigned"] = false
    end

end