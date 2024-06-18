

function OnTouchBegin(wildcard)
    this.RunOnServer("PlaySound")
end

function PlaySound()
    object.sound.Play()
end