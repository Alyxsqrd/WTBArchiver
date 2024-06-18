function Begin()
    print("testb started")
    wait(1)
    local a = GetObjectByName("A")
    if a.netTable["MyVariable"] == 10 then
        print("the variable is set to 10!")
        print("complete")
    end
end

function Tick()
    local b = GetObjectById(244)
    local c = b.netTable["coolant"]
    local d = b.netTable["temp"]
    print(c)
    print(d)
end