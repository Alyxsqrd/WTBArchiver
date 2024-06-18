function OnTouchBegin(touched)
    GetObjectByName("Empty").GetScriptByName("new").RunOnServer("TouchProjectileBrick", touched, object)
end

