

function Begin()
    while true do -- this is a "while" loop, and will continue as long as the value it's checking is == true
        Timer()
    end
end

function Timer()
    -- this is a "for" loop
    -- the first value is the starting number
    -- the second is the max number
    for i = 0, 10 do 
        object.worldText.text = i -- "i" is the current value of the loop, in this case it starts at "0" and goes to "10"
        wait(1)
    end
end