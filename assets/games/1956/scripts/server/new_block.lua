local allow = 0

function Begin()
    waitTick(1)
    if (object.name ~= "copy_block") then
        allow = 1
    else
        print(object.name)
    end
end

function Tick()

    if allow == 1 then
        print("okay then")
    else
        print("not allowed")
    end 

end