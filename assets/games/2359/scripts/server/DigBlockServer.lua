function OnNetMessage(table)
    if table[2] == "takeDamage" then
        --takeDamage(table[4])
        if table[3].name == "DigBlock" then
            table[3].name = "10"
        end

        newhp = tonumber(table[3].name) -1
        table[3].renderer.transparency = (10-newhp) * 10
        table[3].name = tostring(newhp)
        if newhp == 0 then
            table[3].Remove()
        end
    end
end