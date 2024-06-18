function Begin()
    MazeW = 10
    MazeH = 10
    RbX = 0
    RbY = 0
    Maze = {}

    math.randomseed(os.time())

    CreateMazeArray()
end

function CreateMazeArray()
    local columns = {}
    for i=0, MazeH, 1 do
        table.insert(columns, false)
    end
    for i=0, MazeW, 1 do
        table.insert(Maze, columns)
    end
end

function GenerateMaze()
    while true do
        local horizontal = false
        local negDir = false
        --Determines if Direction is Horizontal
        if math.random() > 0.5 then
            horizontal = true
        end
        --Determines if the Direction is Forward or Backward
        if math.random() > 0.5 then
            negDir = true
        end

        local nextX = 0
        local nextY = 0
        if horizontal then
            if negDir then
                nextX = RbX - 1
            else
                nextX = RbX + 1
            end
        else
            if negDir then
                nextY = RbY - 1
            else
                nextY = RbY + 1
            end
        end

        if IsTileOccupied(nextX,nextY) then
            Maze[nextX][nextY] = true
            RbX = nextX
            RbY = nextY
        end
    end
end

function IsTileOccupied(x,y)
    if x > 0 and x < MazeH then
        if y > 0 and y < MazeH then
            
        end
    end
end