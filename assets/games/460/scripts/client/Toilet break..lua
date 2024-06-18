local toiletClicks = 0
local debounce = false

function MouseClick()
	if not debounce then
		toiletClicks = toiletClicks + 1

		if toiletClicks == 10 then
			debounce = true

			for i, toilet in ipairs(This.Children()) do
				toilet.visible = false
				toilet.cancollide = false
			end

			CreateTimer("Reset toilet", 5)
		elseif toiletClicks > 10 then
			toiletClicks = 0
		end
	end
end

function TimerEnd(name)
	if name == "Reset toilet" then
		for i, toilet in ipairs(This.Children()) do
			toilet.visible = true
			toilet.cancollide = true
		end

		toiletClicks = 0
		debounce = false
	end
end