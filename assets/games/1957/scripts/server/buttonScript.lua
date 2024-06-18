function OnTouchBegin(touchingPlayer)
    if touchingPlayer.username == object.parent.parent.netTable.Owner then
        if object.netTable.Purchased == false then
            --print("Work")
            --print(object.netTable.Price)
            object.parent.parent.GetScriptByName("tycoonScript").Run("Purchase", "Unlock", object, object.netTable.Price )
        end
    end
end