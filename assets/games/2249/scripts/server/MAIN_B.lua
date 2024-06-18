local _ = {}
    ----------------------------------------------------------
    local rs, ws, ss, sss, ran
    ----------------------------------------------------------
    function OnCharacterSpawn(char) repeat waitTick(1) until ran == true _.CharacterAdded(char) end
    function OnPlayerJoin(plr) _.Run() waitTick(1) _.PlayerAdded(plr) end
    ----------------------------------------------------------
    local Elements = {}
    local SkillLevels = {3,5,10,15,20,25,30}
    ----------------------------------------------------------
    --local dif, max, rand, float, inf, v3, v2, clr3, cf, cfa, rs, ws, ss, sss = DD.Vars() 
    _.Run = function() 
        --
        rs, ws, ss, sss = _.GNms({"DD","Workspace","ServerStorage","ServerScriptService"})
        local DeclareElems = function(nms, clrs) for i = 1,#nms do local e = {} e.nm = nms[i] e.clr = clrs[i] table.insert(Elements,e) end end
        DeclareElems({"Fire", "Wind", "Water", "Earth", "Light", "Lightning", "Shadow", "Grass"}, 
        {_.c3(196, 40, 28), _.c3(205, 205, 205), _.c3(13, 105, 172), _.c3(105, 64, 40), _.c3(248, 248, 248)}, _.c3(255, 255, 0), _.c3(27, 42, 53), _.c3(31, 128, 29))
        wait(2)
        rs.GetScriptByName("_DD").Run("Test")
        
        --for i,v in pairs(rs.netTable) do print(i.." = "..type(v)) end
        ran = true
        --
    end
    --
    _.SetColor = function(o, clr) if o and o.renderer then o.renderer.color = clr end end
    --
    _.c3 = function(r,g,b) return Color.New(r/255,g/255,b/255) end
    --
    _.GNm = function(n) return GetObjectByName(n) end
    --
    _.GNms = function(nms) local r = {} for i = 1,#nms do r[i] = _.GNm(nms[i]) end return table.unpack(r) end
    --
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
    --
    _.Destroy = function(o) if isServer then if type(o.Remove) == "function" then o.Remove() else DeleteObject(o) end end end
    --
    _.Clone = function(o) if isServer then return DuplicateObject(o) end end
    --
    _.In = function(class, pr) class = class:lower()
        local p 
        --
        if class == "part" or class == "ppart" or class == "folder" or class == "model" then --object
            if isServer then p = CreateEmptyObject() else p = CreateLocalEmptyObject() end 
            waitTick(1) 
            if class == "part" or class == "ppart" then 
                p.SetParent(ss)
                local a = _.In("Renderer", p) local c = _.In("Collider", p) 
                if class == "ppart" then local phys = _.In("Physics", p) end
                p.SetParent(pr)
            end
        elseif isServer and class == "renderer" or class == "collider" or class == "respawn" or class == "script" or class == "physics" then --component
            p = pr.AddComponent(class) waitTick(1)
        end
        --
        return p
    end
    --

--