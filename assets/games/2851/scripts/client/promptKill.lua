function OnInteracted(character)
    this.RunOnServer("KillCharacter", character)
end

function KillCharacter(character)
character.Kill()
end