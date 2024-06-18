function OnPlayerChat(player, message)
    for w in message:gmatch(" ") do print(w) end
end