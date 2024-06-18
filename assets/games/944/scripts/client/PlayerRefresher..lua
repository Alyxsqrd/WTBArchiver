local timeBetweenRefreshes = 5


function Start()
	CreateTimer("timer", 1)
end

function TimerEnd(name)
	if (name == "timer") then
		CreateTimer("timerstart", 0)
		GetPlayers()
	end
	if (name == "timerstart") then
		CreateTimer("timer", timeBetweenRefreshes)
	end
end

function GetPlayers()
	local playerTracker = PartByName("Player Tracker")
	if (playerTracker != nil) then
		-- clear out table
		for k in pairs (playerTracker.table) do
		    playerTracker.table[k] = nil
		end

		-- populate with up-to-date players
		local i = 0
		for k,v in pairs(GetAllPlayers()) do
			playerTracker.table[i] = v
			i = i + 1
		end

		print("successful refresh")
	end
end

function HostSwitched(isNewHost)
	playerManager.table = nil
end