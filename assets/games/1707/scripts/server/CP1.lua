function Begin()
    printScreen("hello there!", 10)
end

function OnTouchBegin(touched)
    if (IsCharacter(touched)) then
        print("recognised as player")
        touched.RespawnHere(Vector3.New(5,2,55))
        print("touched!")
    end
end