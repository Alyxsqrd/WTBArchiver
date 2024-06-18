local Player = GetLocalPlayer()

function OnPlayerJoin(player)
	print("debug")
	this.RunOnServer("SendChatMessage", player)
end

function SendChatMessage(character)
    wait(3)
    Player.SendSystemChat("Applester: Welcome, " .. Player.username .. ", to my farm!")
    object.sound.PlayLocal()
    wait(3)
    Player.SendSystemChat("Applester: I need your help collecting 30 apples that I've accidentally scattered across the farm. Someone from some obviously made up place called the ''IRS'' said he's going to take a look at my tax returns unless I bake him an apple pie. And I've got to tell you " .. Player.username .. ", I may not have been so truthful when I was filing them!")
    object.sound.PlayLocal()
    wait(14)
    Player.SendSystemChat("Applester: I know if you help me, you'll be an accessory to a crime, but I really need help! How about this, you help me, and I'll give you an awesome prize, seem fair? Great! You'll want to look around for green and red apples, once found, walk in to them to pick them up! After you've collected all 30, come inside the barn for your prize.")
    object.sound.PlayLocal()
end	