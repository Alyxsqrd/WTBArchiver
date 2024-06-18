local lights = PartsByNames({"Light cover", "Flourescent tube", "Police spawn light fixture"})

for i, part in ipairs(lights) do
	part.color = newColor(8, 8, 8, 1)
end