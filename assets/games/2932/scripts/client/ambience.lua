--[[ AMBIENCE VALUES
	LIGHTER
		Brightness = 1
		Color = #CCBFB1
	LIGHT
		Brightness = 0,5
		Color = #8A7E72
	NEUTRAL
		Brightness = 0.3
		Color = #382F26
	DARK
		Brightness = 0.5
		Color = #105680
	DARKER
		Brightness = 1
		Color = #0088DA

--]]

function Begin()
   	Event.Bind(this, "updateAmbience")
	
	cCCBFB1= Color.ColorFromHex("CCBFB1")
	c8A7E72= Color.ColorFromHex("8A7E72")
	c382F26= Color.ColorFromHex("382F26")
	c105680= Color.ColorFromHex("105680")
	c0088DA= Color.ColorFromHex("0088DA")
	object.light.color = c382F26
	object.light.brightness = 3 / 100
	SendSystemChatToAll(object.light.brightness)
	SendSystemChatToAll(object.light.color)
end

function updateAmbience(ambience)
	
	SendSystemChatToAll(ambience)
    	if ambience == "lighter" then
		object.light.color = cCCBFB1
		object.light.brightness = 0.5
    	elseif ambience == "light" then
		object.light.color = c8A7E72
		object.light.brightness = 0.4
	elseif ambience == "neutral" then
		object.light.color = c382F26
		object.light.brightness = 0.3
	elseif ambience == "dark" then
		object.light.color = c105680
		object.light.brightness = 0.2
    	elseif  ambience == "darker" then
		object.light.color = c0088DA
		object.light.brightness = 0.1
    end
	SendSystemChatToAll(object.light.brightness)
	SendSystemChatToAll(object.light.color)
end

