local completed = false
local revealed = false


function Begin()
    Event.Bind(this, "CompleteGame")
    Event.Bind(this, "RevealUpsideDown")
end

function OnTouchBegin(wildcard)
    if IsCharacter(wildcard) then
        if not completed then
            GetLocalPlayer().ClearCheckpoint()
            GetLocalPlayer().RespawnHere(GetObjectByName("AltarRespawn").position + Vector3.New(0, 2, 0))
            GetLocalPlayer().SendSystemChat("[A cold breeze brushes your arm. It is familiar.]")
            WorldSettings.skybox = "sunrise"
            GetObjectByName("The Sun").light.enabled = true
            GetObjectByName("The Sun").light.brightness = 1.2
            Event.Broadcast("CompleteGame")
        else
            wildcard.gravityDirection = Vector3.New(0, 1, 0)
            Event.Broadcast("RevealUpsideDown")
            PlayOneShot(22, 1 , 0.66)
            PlayOneShot(79, 1, 1)
            WorldSettings.gravityMultiplier = 0.5
            WorldSettings.jumpPower = 15
        end
    end
end

function OnCharacterSpawn(character)
    if revealed then
        character.gravityDirection = Vector3.New(0, 1, 0)
    end
end

function CompleteGame()
    completed = true
end

function RevealUpsideDown()
    revealed = true
end