local c = 700

function Start()
 CreateTimer("in", 1)
 end

function TimerEnd(name)
   if name == "in" then
   local a = PartByName("c")
   local f = PartByName("f")
   local a2 = PartByName("c2")
   local f2 = PartByName("f2")
   c = c + 1
   a.text.text = c .. "c"
   f.text.text = (c * 9 / 5) + 32 .. "f"
   a2.text.text = c .. "c"
   f2.text.text = (c * 9 / 5) + 32 .. "f"
    if c < 1000 then
    CreateTimer("in", 1)
    elseif c == 1000 then
    c = c - 300
    CreateTimer("in", 1)
    end
   end
 end