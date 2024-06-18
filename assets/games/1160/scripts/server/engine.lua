local wave = GetObjectByName("wave")
local wavespeed = -1
local height = 20
local started = false
local diaster = 1

function Begin()
    wavestartpos = wave.position
    print(wavestartpos)
    
    while true do
      wait(1)
      timecount()
    end
  end
  
  function Tick()
    wave.position = wave.position + Vector3.New(0, 0, wavespeed)
      
  end
  
  function timecount()
    if diaster == 0 then
       started = false
    end
    if  diaster == 1 then
      wavestarted = true
    end
  end
  