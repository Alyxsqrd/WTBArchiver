local _DD = {} local _G = {} 
-- -- -- -- -- -- -- -- -- -- -- -- 
-- Note: https://goonlinetools.com/lua-beautifier/
-- Note: FOLD ALL (Ctrl + K + 0)  |  UNFOLD ALL (Ctrl + K + J)
-- -- -- -- -- -- -- -- -- -- -- -- 
local inf, v3, v2, cf, cfa, rs, ws, ss, sss  = math.huge, Vector3.New, Vector2.New, CFrame.New, CFrame.Angles, nil, nil, nil, nil
local DD_Config = rs 

--------------------------------------------------------
function SetColor(o, clr) if o and o.renderer then o.renderer.color = clr end end --Can be modular
--
function Destroy(o) if isServer then if type(o.Remove) == "function" then o.Remove() else DeleteObject(o) end end end --Can be modular
--------------------------------------------------------
function c3(r,g,b) return Color.New(r/255,g/255,b/255) end --Cannot be modular, returns a value, suffer
function clr3(r,g,b) return c3(r,g,b) end
--
local CFrame = {} --TO:DO ~ Write entire CFrame library here 
    --
    CFrame.p = v3(0,0,0)
    --
    CFrame.New = function() 

    end
    --
    CFrame.Angles = function() 

    end
--
function GNm(n) return GetObjectByName(n) end --Cannot be modular, returns a value, suffer
--
function GNms(nms) local r = {} for i = 1,#nms do r[i] = _.GNm(nms[i]) end return table.unpack(r) end --Cannot be modular, returns a value, suffer
--
function Clone(o) if isServer then return DuplicateObject(o) end end --Cannot be modular, returns a value, suffer
--
function In(class, pr) class = class:lower() --Cannot be modular, returns a value, suffer
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
local function FindFirstChild(a, b) --return whether you can find the child "b" under parent a
    
end
local function FindFirstChildOfClass(a, b) --return whether you can find the child of class "b" under parent a

end
local function IsDescendantOf(a, b) --return if b is a descendant of a

end
local function WaitForChild(a, b) local child = FindFirstChild(a,b) repeat wait(.25) until child ~= nil end --wait for child "b" under parent a
--------------------------------------------------------

_DD.Init = function() 
    if not _G.DD then _G.DD = {} local DD = _G.DD local TR,FL = true,false
		-- -- -- -- -- -- -- -- -- -- -- -- 
        local function typeof(a) return type(a) end-- might have to code this to detect different world to build ClassNames
		local function Is(dir,ty) return typeof(dir) == ty end
		local function IsInTable(a,b) for i = 1,#b do local v = b[i] if v == a then return TR end end return FL end --return if value a is found in table b
		local function FindFirstChildChain(stf) local r = stf[1] for i = 2, #stf do local id = stf[i] if r and r:FindFirstChild(id) then r = r:FindFirstChild(id) else return nil end end return r end
		local function FFCC(stf) return FindFirstChildChain(stf) end
		local function FFC(a,b) return a:FindFirstChild(b) end
		local function FFCOC(a,b) return a:FindFirstChildOfClass(b) end
		local function FindChildren(dir,reqst) local rsp = {} if dir then for i = 1,#reqst do local v = reqst[i] if v then rsp[i] = FFC(dir,v) else rsp[i] = nil end end end return table.unpack(rsp) end
		local function FFO(dir, nm, clss) if dir and nm and clss then local c = dir:GetChildren() for i = 1,#c do local v = c[i] if dir and v then if v.Name == nm and v:IsA(clss) then return v end local r = FFO(v, nm, clss) if tostring(r) == nm then return r end end end end return nil end --Recursive search dir for instance nm of clss 
		local function FindFirstOf(...) return FFO(...) end --Recursive search dir for instance nm of clss 
		local function FFF(dir, nm) return(FFO(dir,nm,"Folder")) end --Recursive search dir for folder nm
		local function FindFirstFolder(...) return FFF(...) end --Recursive search dir for folder nm
		local function WaitForChildChain(stf) local r = stf[1] for i = 2, #stf do local id = stf[i] if id and r then r = r:WaitForChild(id) else return nil end end return r end
		local function WFCC(stf) return WaitForChildChain(stf) end
		local function WFC(a,b) return a:WaitForChild(b) end
		local function WaitForChildren(dir,reqst) local rsp = {} if dir then for i = 1,#reqst do local v = reqst[i] if v then rsp[i] = WFC(dir,v) else rsp[i] = nil end end end return table.unpack(rsp) end
	    local function WFCD(dir, reqst) return WaitForChildren(dir,reqst) end
		local function ParseDirectoryChain(stf) local r = stf[1] for i = 2, #stf do local id = stf[i] if tonumber(id) then id = tonumber(id) end if r ~= nil and r.vl ~= nil and r.vl[id] ~= nil then r = r.vl[id] else return nil end end return r end --  DD.PrintTable(r,"PDC -> "..r.Name..".vl["..id.."] "..i.."/"..#stf)
	    local function PDC(stf) return ParseDirectoryChain(stf) end
		local function Get(Inst,Attrib,Compare) if Compare ~= nil then return Inst:GetAttribute(Attrib) == Compare else return Inst:GetAttribute(Attrib) end end
		local function Set(Inst,Attrib,Val) Inst:SetAttribute(Attrib,Val) return Attrib end
		local function AC(dir,func) return dir.AttributeChanged:Connect(function(a) if dir then func(a, Get(dir,a)) end end) end
		local function ACP(dir,i,func) return dir:GetAttributeChangedSignal(i):Connect(function() if dir then func(i, Get(dir,i)) end end) end
		local function SetP(dir,i,v) if not (dir[i] == v) then dir[i] = v end end --print("SetP() -> THIS IS SETTING "..dir.Name.."["..i.."] TO \n"..v.."\n AAAAAAAAAAAAAAAAAAAAAAAAAAAA") print(dir[i].."=="..v.." | "..tostring(not (dir[i] == v))) 
		local function SetName(a,b) SetP(a,"Name",b) end
		local function SetVisible(a,b) SetP(a,"Visible",b) end
		-- -- -- -- -- -- -- -- -- -- -- -- 
		local function CreateIn(ty,dir,nm) local f = dir:FindFirstChild(nm) if not f then f = Instance.new(ty) f.Name = nm f.Parent = dir end return f end -- bruh
		local function CreateIns(ty,dir,ins) for i = 1, #ins do local v = ins[i] CreateIn(ty,dir,v) end end
		local function CreateV(ty,dir,nm,v) local f = dir:FindFirstChild(nm) if not f then f = Instance.new(ty) f.Name = nm f.Value = v f.Parent = dir end return f end -- bruh
		local function CreateF(dir,nm) return CreateIn("Folder",dir,nm) end -- CreateIn is used to create child object under dir
		local function CreateFs(dir,ins) CreateIns("Folder",dir,ins) end 
        local function NewSound(id,pr,nm,vl) local sfx = CreateIn("Sound",pr,nm) sfx.SoundId = id sfx.Volume = vl return sfx end
		local function WeldBetween(a, b, c) -- Weld A to B and parent the weld instance to C
			local weld = In("ManualWeld") 
			a.CanCollide = false b.CanCollide = false
			a.Anchored = false b.Anchored = false
			weld.C0 = a.CFrame:inverse() * b.CFrame 
			weld.Part0 = a weld.Part1 = b weld.Parent = c
			return weld
		end 
		-- -- -- -- -- -- -- -- -- -- -- -- 

    end
    _DD.SetupProject(scri)
end



























--------------------------------------------------------
    _.PlayerAdded = function(plr) print(plr.username.." PLAYER ADDED")
    end
    --
    _.CharacterAdded = function(char) print(char.username.." CHARACTER ADDED")
        local Element = Elements[math.random(1,#Elements)]
        local PetBrick = _.In("PPart", ws) 
        PetBrick.position = char.position
        _.SetColor(PetBrick, Elements[math.random(1,#Elements)].clr)
    end
    _.Run = function() 
        --
        local DeclareElems = function(nms, clrs) for i = 1,#nms do local e = {} e.nm = nms[i] e.clr = clrs[i] table.insert(Elements,e) end end
        DeclareElems({"Fire", "Wind", "Water", "Earth", "Light", "Lightning", "Shadow", "Grass"}, 
        {_.c3(196, 40, 28), _.c3(205, 205, 205), _.c3(13, 105, 172), _.c3(105, 64, 40), _.c3(248, 248, 248)}, _.c3(255, 255, 0), _.c3(27, 42, 53), _.c3(31, 128, 29))
        --
    end    
----------------------------------------------------------












function Begin() --module loading

end

 ----------------------------------------------------------
 function OnCharacterSpawn(char) CharacterAdded(char) end end
 function OnPlayerJoin(plr) Run() waitTick(1) PlayerAdded(plr) end 
 ----------------------------------------------------------