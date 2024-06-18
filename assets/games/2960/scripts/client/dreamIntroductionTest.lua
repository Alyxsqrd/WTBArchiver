local dreaming = false
local introduction = true

function OnTouchBegin(wildcard)
  if IsCharacter(wildcard) then
    if dreaming == false then
      introduction = true
      wildcard.player.SendSystemChat("You just woke up from a deep, silent slumber, that was disturbed suddenly by a nightmare you couldn't control.")
      wait(8)
      wildcard.player.SendSystemChat("But you can control it.")
      wait(6)
      wildcard.player.SendSystemChat("You are stronger than you know.")
      wait(5)
      wildcard.player.SendSystemChat("You must fight it for your lucid freedom.")
      wait(2)
      wildcard.player.SendSystemChat("Press E to dream.")
      introduction = false
    else
      if Input.KeyPressed("E") then
        if introduction == false then
          introduction = false
          print("teleported player")
          wildcard.position = Vector3.New(1, 999, 1)
          dreaming = true
        end
      end
    end
  end
end