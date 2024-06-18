function OnCharacterSpawn(character)
    character.jumps = 1
    Intermission()
 end

function StartGame()
    local Status = GetObjectById(152)
    SendSystemChatToAll("Starting in a few seconds")
    wait(3)
    local Blockade = GetObjectById(156)
    Blockade.blockRenderer.visible = false
    Blockade.collider.enabled = false
    local InGameTime = 180
    SendSystemChatToAll("Game has started round lasts 3 mins")
    for i=InGameTime, 0,-1 do
        Status.worldText.text = "Game in progress "..i
        if i == 0 then 
            local GetPlayers = GetAllPlayers()
            for i, v in pairs(GetPlayers) do
                v.character.Kill()
                Intermission()
            end
        end

        wait(1)
    end
end

function TpPlayers()
    local DeathUser = Random.Player()
    DeathUser.character.position = Vector3.new(23, 5.0929, -15)
    SendSystemChatToAll(DeathUser.username.." has been selected as Death")
    local GetPlayers = GetAllPlayers()
    
    for i, v in pairs(GetPlayers) do
        if v.username ~= DeathUser.username then 
            v.character.position = Vector3.new(14.5, 4.6, -16.8)
        end

        if i == #GetAllPlayers() then 
            StartGame()
        end
    end
end

function Intermission()
    SendSystemChatToAll("Intermission")
    local Blockade = GetObjectById(156)
    Blockade.blockRenderer.visible = true
    Blockade.collider.enabled = true
    local IntermissionTimer = 30
    for i=IntermissionTimer, 0,-1 do
        local Status = GetObjectById(152)
        Status.worldText.text = "Intermission "..i
        wait(1)
        if i == 0 then
            Status.worldText.text = "Intermission over!"
            TpPlayers()
        end
    end
end