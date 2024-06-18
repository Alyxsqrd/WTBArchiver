local oneGoesTo = "3"
local twoGoesTo = "5"
local threeGoesTo = "2"
local fourGoesTo = "0"
local fiveGoesTo = "4"


function OnInteracted(character)
    local puzzle = GetObjectByName("Scarecrow Puzzle")
    
    if (not puzzle.localTable["playedHint"]) then
        character.player.SendSystemChat("Wow, these are some loud crows.")
        puzzle.localTable["playedHint"] = true
    end

    if (puzzle.localTable["next"] == nil) then
        puzzle.localTable["next"] = "1"
    end

    if (puzzle.localTable["next"] == "0") then
        return
    end

    if (puzzle.localTable["next"] == object.name) then
        if (object.name == "1") then
            PlayCaws(oneGoesTo)
        elseif (object.name == "2") then
            PlayCaws(twoGoesTo)
        elseif (object.name == "3") then
            PlayCaws(threeGoesTo)
        elseif (object.name == "4") then
            PlayCaws(fourGoesTo)
        elseif (object.name == "5") then
            PlayCaws(fiveGoesTo)
        end
    else
        PlayOneShotAt(21, 1, 0.66, object.position, 500)
        puzzle.localTable["next"] = "1"
    end
end

function PlayCaws(times)
    local puzzle = GetObjectByName("Scarecrow Puzzle")

    if (times == "0") then
        puzzle.localTable["next"] = "0"
        Event.Broadcast("CompleteScarecrowPuzzle")
    else
        puzzle.localTable["next"] = times
        for i = 1, times do
            PlayOneShotAt(Random.Number(76, 78), 2.5, 1, object.position, 500)
            wait(0.66)
        end
    end
end