function Begin()
    levelCanBegin = true
    levelBegun = false
    minutesLeft = 5
    secondsLeft = 0
    Event.Bind(this,"allScrapCollected")
end

function OnTouchBegin()
    if(not levelBegun and levelCanBegin) then
        minutesLeft = 5
        secondsLeft = 0
        levelBegun = true
        countDown()
    end
end

function allScrapCollected()
    levelBegun = false
    levelCanBegin = false
end

function countDown()
    if(levelBegun)then
        if(secondsLeft > 0)then
            secondsLeft = secondsLeft - 1
            timer("countDown",1)
        else
            if(minutesLeft > 0) then
                SendSystemChatToAll(tostring(minutesLeft).." MINUTES LEFT")
                minutesLeft = minutesLeft - 1
                secondsLeft = 60
                timer("countDown",1)
            else
                GetAllCharacters()[1].position = GetObjectByName("Office2TeleportOut").position
                levelBegun = false
                Event.Broadcast("resetScrap")
            end
        end
    end
end