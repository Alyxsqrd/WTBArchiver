function OnPlayerChat(player, message)
    if message == "sell" or message == "buy" then
        object.GetChildByName("Command").worldText.text = message
    end
    if message != "sell" or message != "buy" then
        object.GetChildByName("Stock").worldText.text = message
    end
end