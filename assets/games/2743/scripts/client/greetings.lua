function OnTouchBegin(wildcard)
if IsCharacter(wildcard) then
this.RunOnServer("SendChatMessage", wildcard)
end
end
function SendChatMessage(character)
character.player.SendSystemChat("Eggster > Testing, testing, 1, 2, 3. . . Perfect! Can you hear me loud and clear, PLAYER NAME?")
wait(5)
character.player.SendSystemChat("Eggster > Greetings, adventurer! I come to you with an urgent message. You've been stranded on a remote island, and it seems that Easter is in jeopardy!")
wait(8)
character.player.SendSystemChat("Eggster > Every Easter egg is made in a factory located on this island. However, a group of mischievous rabbits broke into the factory and accidentally caused an explosion, scattering all the eggs far and wide. You must collect them before Easter arrives!")
wait(8)
character.player.SendSystemChat("Eggster > Oh, and as a token of appreciation, for every egg you find and return, I will grant you a free copy of it to keep as a souvenir of your brave quest!")
wait(8)
character.player.SendSystemChat("Eggster > Now, let's get started. I'll be your guide, but remember, time is of the essence. We must find all the eggs before Easter arrives. Are you ready, player?")
wait(8)
character.player.SendSystemChat("Eggster > I see you haven't said anything, but no worries! I'll take your silence as a resounding yes. Let's go!")
end