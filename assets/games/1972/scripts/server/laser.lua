function Begin()
    
end

function Tick()
    local characters = GetAllCharacters()

    for i = 1,#(characters)
    do 
        local hit = LineCast(characters[i].position,object.position)
        print(hit.hitWildcard.name) 
    end
end

function OnCharacterSpawn(character)
    character.speed = 3
    character.gravityPower = 0.5
end