local temp = 700
function Start()
CreateTimer("a", 1)
print("made")
end
function TimerEnd()
temp = temp + 1
if temp == 1000 then
local pos = newVector3(3.39,19.39002,3.39);
Explode(pos, 1000, 99999, true, false)
temp = temp - 300
Start()
end
CreateTimer("a", 1)
end


