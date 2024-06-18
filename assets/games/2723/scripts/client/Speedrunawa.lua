
function onTouch(Part)

check = Part.Parent:findFirstChild("Humanoid")

if check.Parent ~= nil then

check.WalkSpeed=100

end

end

script.Parent.Touched:connect(onTouch)