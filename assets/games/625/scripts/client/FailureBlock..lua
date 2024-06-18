print('script started');

function FixedUpdate()
end

function Update()
end

function StartCollision(_other)
	if (IsHost) then
		print("hit fail");
		if (_other.type == "Player") then
			print("hit fail local");
			local part = _other.table.checkpoint;
			if (part != nil) then
				_other.HostSetPosition(part.position + part.up);
			else
				_other.HostSetPosition(Vector3.up * 20);
			end
		end
	end
end

function EndCollision(_other)
end
