function OnTouchBegin(touched)
    if IsCharacter(touched)
    then
        if touched.gravityPower == 1
        then
            this.RunOnServer("turnRed")
        else
            this.RunOnServer("turnBlue")
        end
    end
end

function turnRed()
    object.renderer.color = Color.New(255, 0, 0)
    object.name = "RedRock"
end

function turnBlue()
    object.renderer.color = Color.New(0, 0, 255)
    object.name = "BlueRock"
end