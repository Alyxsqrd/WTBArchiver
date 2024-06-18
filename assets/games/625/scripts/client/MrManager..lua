function InitialPlayerSpawn(_other)
	print("other player joined");
	print(_other.name);
end

function Start()
	CreateTimer("t",1)
end

function TimerEnd(name)
	if (name=="t")then
		--LocalPlayer().size = LocalPlayer().size/2
	end
end