

function Begin()
    Event.Bind(this, "Tester")
    wait(20)
    Event.Unbind(this, "Tester")
end

function Tester(msg)
    printScreen("The secret message is "..msg, 5)
end