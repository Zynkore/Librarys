local Root = script.Parent.Parent
local Creator = require(Root.Creator)

local New = Creator.New

return function(Parent)
	local Divider = {}

	Divider.Root = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 10),
		Parent = Parent,
	}, {
		New("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.9,
			BorderSizePixel = 0,
			Size = UDim2.new(1, -20, 0, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			ThemeTag = {
				BackgroundColor3 = "Divider",
			},
		})
	})

	return Divider
end
