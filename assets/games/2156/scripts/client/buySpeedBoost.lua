function Begin()
    purchase = 1
    setprice = 0
    if object.name == "SpeedBoostBuy" then
        purchase = 1
        setprice = 3
    elseif object.name == "HighGravityBuy" then
        purchase = 6
        setprice = 3
    elseif object.name == "LowGravityBuy" then
        purchase = 2
        setprice = 5
    elseif object.name == "GiganticBuy" then
        purchase = 3
        setprice = 5
    elseif object.name == "MiniatureBuy" then
        purchase = 4
        setprice = 7
    elseif object.name == "ReverseGravityBuy" then
        purchase = 5
        setprice = 1005
    end
    --print(object.name .. " assigned "..purchase .. " for price of ".. setprice)
end

function OnTouchBegin(touycha)
    local theTable = {3, touycha.player.netId, purchase, setprice}
    GetObjectByName("leaderboardManager").NetMessagePlayer(GetHostPlayer(), theTable)
end