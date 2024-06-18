local door = GetObjectByName("door")
function Begin()
    print("door script started")
end
function OnTouchBegin(touched)
    door.blockRenderer.transparency = 50.0
    door.collider.enabled = false
    wait(2.0)
    door.blockRenderer.transparency = 0.0
    door.collider.enabled = true
end

