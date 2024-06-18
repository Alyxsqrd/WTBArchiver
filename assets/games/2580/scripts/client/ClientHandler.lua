rat = CreatePremade("Rat")

function OnCharacterSpawn(character)
    character.visible = false
    character.displayName = false
end

function LateTick()
    local character = GetLocalCharacter()

    if character.alive == true then
        rat.position = character.position - Vector3.New(0,0.76,0)
        rat.rotation = character.rotation
    end
end