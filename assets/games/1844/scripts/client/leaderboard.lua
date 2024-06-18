

function OnNetTableUpdated()
    if isHost then
        local newText = "Leaderboard"
        for i,v in pairs(GetAllPlayers()) do
            if object.netTable[v.username] then
                newText = newText .. "<br>" .. v.username .. ": " .. object.netTable[v.username]
            end
        end
        object.worldText.text = newText
    end
end