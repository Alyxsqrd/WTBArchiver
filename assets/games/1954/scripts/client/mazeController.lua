local monaXPlus
local monaXMinus
local monaZPlus
local monaZMinus
local correctMona = 0
local correctCounter = 0
local correctToWin = 10
local complete = false


function Begin()
    monaXPlus = GetObjectByName("MonaXPlus")
    monaXMinus = GetObjectByName("MonaXMinus")
    monaZPlus = GetObjectByName("MonaZPlus")
    monaZMinus = GetObjectByName("MonaZMinus")

    xPlusTarget = GetObjectByName("MazeXPlusTarget")
    xMinusTarget = GetObjectByName("MazeXMinusTarget")
    zPlusTarget = GetObjectByName("MazeZPlusTarget")
    zMinusTarget = GetObjectByName("MazeZMinusTarget")

    Event.Bind(this, "MazeDoorXPlus")
    Event.Bind(this, "MazeDoorXMinus")
    Event.Bind(this, "MazeDoorZPlus")
    Event.Bind(this, "MazeDoorZMinus")

    RandomizeProps()
    RandomizeMona()
end

function MazeComplete()
    if complete then
        return
    end
    complete = true
    
    PlayOneShot(79, 1, 1)
    PlayOneShot(23, 0.5, 0.25)

    GetLocalCharacter().position = GetObjectByName("MazeCompleteTarget").position
end

function MazeCorrect()
    correctCounter = correctCounter + 1

    if (correctCounter >= correctToWin) then
        MazeComplete()
    end
end

function MazeIncorrect()
    correctCounter = 0
end

function MazeDoorXPlus()
    GetLocalCharacter().position = xPlusTarget.position

    if (correctMona == 0) then
        MazeCorrect()
    else
        MazeIncorrect()
    end

    RandomizeProps()
    RandomizeMona()
end

function MazeDoorXMinus()
    GetLocalCharacter().position = xMinusTarget.position

    if (correctMona == 1) then
        MazeCorrect()
    else
        MazeIncorrect()
    end

    RandomizeProps()
    RandomizeMona()
end

function MazeDoorZPlus()
    GetLocalCharacter().position = zPlusTarget.position

    if (correctMona == 2) then
        MazeCorrect()
    else
        MazeIncorrect()
    end

    RandomizeProps()
    RandomizeMona()
end

function MazeDoorZMinus()
    GetLocalCharacter().position = zMinusTarget.position

    if (correctMona == 3) then
        MazeCorrect()
    else
        MazeIncorrect()
    end

    RandomizeProps()
    RandomizeMona()
end

function RandomizeProps()
    for i,v in pairs(GetObjectsByName("MazeProp")) do
        local rand = Random.NumberRounded(0, 1)
        if (rand == 0) then
            v.renderer.visible = false
        else
            v.renderer.visible = true
        end
    end
end

function RandomizeMona()
    local rand = Random.NumberRounded(0, 3)

    if (rand == 0) then
        monaXPlus.renderer.visible = true
        monaXMinus.renderer.visible = false
        monaZPlus.renderer.visible = false
        monaZMinus.renderer.visible = false

        monaXPlus.collider.enabled = true
        monaXMinus.collider.enabled = false
        monaZPlus.collider.enabled = false
        monaZMinus.collider.enabled = false
    elseif (rand == 1) then
        monaXPlus.renderer.visible = false
        monaXMinus.renderer.visible = true
        monaZPlus.renderer.visible = false
        monaZMinus.renderer.visible = false

        monaXPlus.collider.enabled = false
        monaXMinus.collider.enabled = true
        monaZPlus.collider.enabled = false
        monaZMinus.collider.enabled = false
    elseif (rand == 2) then
        monaXPlus.renderer.visible = false
        monaXMinus.renderer.visible = false
        monaZPlus.renderer.visible = true
        monaZMinus.renderer.visible = false

        monaXPlus.collider.enabled = false
        monaXMinus.collider.enabled = false
        monaZPlus.collider.enabled = true
        monaZMinus.collider.enabled = false
    elseif (rand == 3) then
        monaXPlus.renderer.visible = false
        monaXMinus.renderer.visible = false
        monaZPlus.renderer.visible = false
        monaZMinus.renderer.visible = true

        monaXPlus.collider.enabled = false
        monaXMinus.collider.enabled = false
        monaZPlus.collider.enabled = false
        monaZMinus.collider.enabled = true
    end

    correctMona = rand
end