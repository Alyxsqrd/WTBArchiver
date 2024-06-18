local gathered = false
local turnedIn = false

local redTurned = false
local blueTurned = false
local greenTurned = false
local purpleTurned = false
local yellowTurned = false


function Begin()
    Event.BindFunction(this, object.name .. "SkullGet", "Gather")

    Event.Bind(this, "RedSkullTurnedIn")
    Event.Bind(this, "BlueSkullTurnedIn")
    Event.Bind(this, "GreenSkullTurnedIn")
    Event.Bind(this, "PurpleSkullTurnedIn")
    Event.Bind(this, "YellowSkullTurnedIn")
end

function OnCharacterSpawn(character)
    if gathered and not turnedIn then
        GetLocalCharacter().GrantItem(object.name .. " Skull")
    end
end

function OnInteracted(character)
    if IsValid(character) then
        if character.HasItem(object.name .. " Skull") then
            character.RemoveItem(object.name .. " Skull")
            TurnIn()
        else
            PlayOneShot(21, 1, 0.33)
            GetLocalPlayer().SendSystemChat("I think I'll need the " .. object.name .. " Skull for this..")
        end
    end
end

function Gather()
    if gathered then
        return
    end

    if turnedIn then
        return
    end

    GetLocalCharacter().GrantItem(object.name .. " Skull")
    GetLocalPlayer().SendSystemChat("[You found the " .. object.name .. " Skull!]")
    PlayOneShot(22, 1, 1)

    gathered = true
end

function TurnIn()
    turnedIn = true
    
    local turnInVisual = GetObjectByName(object.name .. "SkullTurnedInVisual")
    if IsValid(turnInVisual) then
        turnInVisual.renderer.visible = true
        turnInVisual.collider.enabled = true
        turnInVisual.light.enabled = true
        turnInVisual.sound.Play()
    end

    object.interactable.visible = false
    GetLocalPlayer().SendSystemChat("[A deep rumble can be heard as you place the " .. object.name .. " Skull in the pentagram]")
    PlayOneShot(22, 1, 1)
    PlayOneShot(79, 1, Random.Number(0.95, 1.1))

    Event.Broadcast(object.name .. "SkullTurnedIn")

    CheckAllSkulls()
end

function CheckAllSkulls()
    if redTurned and blueTurned and greenTurned and purpleTurned and yellowTurned then
        Event.Broadcast("CompleteSkulls")

        GetLocalPlayer().SendSystemChat("[The sounds of machinery can be heard in the walls nearby]")
        
        PlayOneShot(23, 0.75, 0.1)

        PlayOneShot(79, 1.25, 1)
        wait(2)
        PlayOneShot(79, 0.5, 1.1)
        wait(0.75)
        PlayOneShot(79, 1, 0.95)
        wait(3)
        PlayOneShot(79, 0.66, 1)
        wait(2.5)
        PlayOneShot(79, 0.33, 1.1)
        wait(1)
        PlayOneShot(79, 0.25, 0.95)
    end
end

function RedSkullTurnedIn()
    redTurned = true
end

function BlueSkullTurnedIn()
    blueTurned = true
end

function GreenSkullTurnedIn()
    greenTurned = true
end

function PurpleSkullTurnedIn()
    purpleTurned = true
end

function YellowSkullTurnedIn()
    yellowTurned = true
end