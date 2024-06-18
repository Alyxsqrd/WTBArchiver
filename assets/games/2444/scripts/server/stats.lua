function Begin()
    print("started")
    object.netTable["water"] = 100
    print("started")
    while true do
        wait(1)
        timecount()
    end
end

function timecount()
    object.netTable["water"] = object.netTable["water"] - 0.1
    print(object.netTable["water"])

function waterdrink()
    object.netTable["water"] = object.netTable["water"] + 25
    print(object.netTable["water"])
end