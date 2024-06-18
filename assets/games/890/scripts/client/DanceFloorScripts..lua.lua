function Start()
print('script started');
CreateTimer("NeonLights", 0.5)
end

function TimerEnd(name)
if(IsHost)then
CreateTimer("NeonLights".. math.random() .. os.time(os.date("!*t")), math.random())
This.color = newColor(math.random(),math.random(),math.random(), 1);
end
end