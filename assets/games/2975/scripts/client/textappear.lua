local troph = GetObjectByName("Trophy")
local player = GetLocalPlayer()

function OnInteracted(character)
	this.RunOnServer("SendChatMessage", player)

end

function SendChatMessage(character)
    wait(1)
    character.SendSystemChat("Applester: Excellent, thank you so much for your help. Please take this as a token of appreciation.  Promo Code: 4PPL3543V3R | Remember, let's keep the event fun. Don't share the code!")
end