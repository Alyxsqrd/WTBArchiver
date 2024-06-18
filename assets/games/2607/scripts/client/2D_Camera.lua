local camera2D = Vector3.new(0, 0, 0)
local defaultCamera = Vector3.new(0, 5, -10)

function Tick()
  if Input.KeyPressed("LeftShift") then
    local myPlayer = game.Players.LocalPlayer
    local character = myPlayer.Character
    local camera = character.Camera

    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = CFrame.new(camera2D)
  end

  if Input.KeyReleased("LeftShift") then
    local myPlayer = game.Players.LocalPlayer
    local character = myPlayer.Character
    local camera = character.Camera

    camera.CameraType = Enum.CameraType.Custom
    camera.CFrame = CFrame.new(defaultCamera)
  end
end