local granted = false
local used = false


function Begin()
    Event.Bind(this, "CompleteScarecrowPuzzle")
    Event.Bind(this, "UnlockGreen")
end

function OnCharacterSpawn(character)
    if granted and not used then
        GrantKey()
    end
end

function UnlockGreen()
    used = true
end

function CompleteScarecrowPuzzle()
    PlayOneShot(10, 1, 1)
    granted = true
    
    GrantKey()
end

function GrantKey()
    GetLocalCharacter().GrantItem("Green Key")
    GetLocalPlayer().SendSystemChat("[The scarecrow's arm stretches out and hands you the Green Key]")
end