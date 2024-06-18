local _ = {} local rs, DD, fs, ld 
function Begin()
    rs = GetObjectByName("DD") 
    DD, fs = rs.GetScriptByName("_DD"), rs.netTable 
    for i=1,#fs do print("unpack: "..fs[i]) _[fs[i]] = function() return DD.Run(fs[i]) end end 
    ld = true 
end
 ----------------------------------------------------------
 local ws, ss, sss, ran
 ----------------------------------------------------------
 function OnCharacterSpawn(char) repeat waitTick(1) until ran == true if type(_["CharacterAdded"]) == "function" then _.CharacterAdded(char) end end
 function OnPlayerJoin(plr) repeat waitTick(1) until ld == true if type(_["Run"]) == "function" then _.Run() end waitTick(1) if type(_["PlayerAdded"]) == "function" then _.PlayerAdded(plr) end end 
 ----------------------------------------------------------
    _.PlayerAdded = function(plr)
        print(plr.username.." PLAYER ADDED")
    end
    --
    _.CharacterAdded = function(char)
        print(char.username.." CHARACTER ADDED")
        print("INSTANCING AAA PART")
        local Element = Elements[math.random(1,#Elements)]
        local PetBrick = _.In("PPart", ws) 
        PetBrick.position = char.position
        print(Element.nm)
        _.SetColor(PetBrick, Elements[math.random(1,#Elements)].clr)
        print("PART ADDED")
    end
    _.Run = function() 
        --
        ws, ss, sss = _.GNms({"Workspace","ServerStorage","ServerScriptService"})
        local DeclareElems = function(nms, clrs) for i = 1,#nms do local e = {} e.nm = nms[i] e.clr = clrs[i] table.insert(Elements,e) end end
        DeclareElems({"Fire", "Wind", "Water", "Earth", "Light", "Lightning", "Shadow", "Grass"}, 
        {_.c3(196, 40, 28), _.c3(205, 205, 205), _.c3(13, 105, 172), _.c3(105, 64, 40), _.c3(248, 248, 248)}, _.c3(255, 255, 0), _.c3(27, 42, 53), _.c3(31, 128, 29))
        
        --for i,v in pairs(rs.netTable) do print(i.." = "..type(v)) end
        ran = true
        --
    end    
----------------------------------------------------------