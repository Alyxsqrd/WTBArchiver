local coolant = PartByName("coolant")
function Start()
temp = 300
a()
end
function a()
coolant.size = coolant.size + newVector3(0,-0.01,0)
CreateTimer("coolant lose", 0.25)
end
function TimerEnd()
temp = temp -0.5
a()
end

