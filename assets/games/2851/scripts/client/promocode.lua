function OnInteracted()
    this.RunOnServer("ssc")
end

function ssc()
    SendSystemChatToAll("Congratulations, you've completed the challenge!")
    SendSystemChatToAll("Promocode: aaa")
    SendSystemChatToAll("(redeem the code at worldtobuild.com/level-up/promo-code)")
end