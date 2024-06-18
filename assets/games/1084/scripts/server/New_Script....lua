

function Begin()
  while true do
    wait(1)
    TimerEnd()
  end
 end

function TimerEnd()
   local b = GetObjectById(244)
   local c = b.netTable["temp"]
   local a2 = GetObjectByName("c2")
   local f2 = GetObjectByName("f2")
   local corestat = GetObjectByName("CORESTATUS")
   a2.worldText.text = c .. "c"
   f2.worldText.text = (c * 9 / 5) + 32 .. "f"
   if b.netTable["stat"] == true then
    corestat.worldText.text = "Rising"
   elseif b.netTable["stat"] == false then
    corestat.worldText.text = "Cooling"
   end

    if c < 1000 then
    elseif c == 1000 then
    c = c - 300
    end
 end