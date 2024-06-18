

function OnTouchBegin()
	local m = {
		TestVal = -1
	}
	print("m is "..m["TestVal"])
	NetMessageGlobalAll(m)
end

function OnNetMessage(table)
	local t = table["TestVal"]
	print("t received as "..t)
end

function Test1()
	SendSystemChatToAll("test system chat")
end

function Begin()
	wait(1)
	
	print("supa test 1")
	local t = { "one t", "two t" }
	print("supa test 2")
	for i,v in ipairs(t) do
		print(v)
	end
	print("supa test 3")

	print("test 1")
	local objs = GetObjectsByName("Orange")
	print("test 2")
	for i,v in ipairs(objs) do
		v.renderer.color = Color.red
	end
	print("test 3")

	wait(3)
	local test1 = GetLocalCharacter()
	test1.dod.TestBreak()

	wait(1)
	test1.dod.TestBreak()
end

function OnCharacterDied(chara)
	print("poopy pants died")
	print("name was " .. chara.nickname)
end
