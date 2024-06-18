local minigame1 = "Minigame One"
local minigame2 = "Minigame Two"
local choice = math.random(1,2)
local minigameDisplay = object.Minigame.text

-- Random choice
function OnPlayerJoin(player)
  if choice == 1 then
    minigameDisplay = "Avoid The Lasers!"
  else
    minigameDisplay = "Obby Rush!"
  end
end

-- Running the code when player joins
OnPlayerJoin(player)
