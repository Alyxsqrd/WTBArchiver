LocalPlayer().table.checkpoint = nil;

function StartCollision(_other)
	if (_other.type == "Player") then
		print("getting part");
		local part = _other.table.checkpoint;
		print("got part");
		if (part ~= nil) then
			part.color = newColor(0,1,0,0.3);
		end
		print("worked with part");
		_other.table.checkpoint = This;
		This.color = newColor(1,1,0,0.3);
	end
end

function EndCollision(_other)
end