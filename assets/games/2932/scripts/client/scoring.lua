

function Begin()
   	Event.Bind(this, "updateScore")
	WorldSettings.skybox = "cloudy"
	local dialog = object.GetChildByName("text")
	score = 0
	dialog.worldText.text = score
	treshold1 = 10
	treshold2 = 5
	local ambience = "neutral"
end


function updateScore(updateScore)
	score = score + updateScore
	local dialog = object.GetChildByName("text")
	dialog.worldText.text = score
	-- SendSystemChatToAll("Updated")
	updateSky()
end

function updateSky()
    	if score >= treshold1 then
		WorldSettings.skybox = "day03"
		ambience = "lighter"
    	elseif (score < treshold1) and (score >= treshold2) then
		WorldSettings.skybox = "day01"
		ambience = "light"
	    elseif (score < treshold2) and (score > (0 - treshold2))then
		WorldSettings.skybox = "cloudy"
		ambience = "neutral"
	    elseif (score <= (0 - treshold2)) and (score > (0 - treshold1))then
		WorldSettings.skybox = "night"
		ambience = "dark"
        elseif  (score <= (0 - treshold1)) then
		WorldSettings.skybox = "night-dark"
		ambience = "darker"
        end
	Event.Broadcast("updateAmbience", ambience)
end

  