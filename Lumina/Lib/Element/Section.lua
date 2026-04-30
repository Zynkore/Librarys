local Section = {}
Section.__index = Section
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()

function Section.new(tab, data)
    local self = setmetatable({}, Section)
    self.Theme = tab.Theme
    
    local Group = New("Frame", {
        Parent = tab.Page,
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    })

    local Header = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = self.Theme.Section,
        BackgroundTransparency = 0.5,
        Text = "",
        AutoButtonColor = false,
        Parent = Group
    })
    New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Header})
    New("UIStroke", {Color = self.Theme.Outline, Thickness = 0.8, Parent = Header})
    
    New("Frame", {
        Size = UDim2.new(0, 2, 0, 14),
        Position = UDim2.new(0, 8, 0.5, -7),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Parent = Header
    })

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 18, 0, 0),
        Text = data.Name:upper(),
        TextColor3 = self.Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Parent = Header
    })

    local Arrow = New("TextLabel", {
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(1, -32, 0, 0),
        Text = "▼",
        TextColor3 = self.Theme.SubText,
        TextSize = 10,
        BackgroundTransparency = 1,
        Parent = Header
    })

    self.Container = New("Frame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 38),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Visible = true,
        Parent = Group
    })
    New("UIListLayout", {Padding = UDim.new(0, 6), Parent = self.Container})

    Header.MouseButton1Click:Connect(function()
        self.Container.Visible = not self.Container.Visible
        Arrow.Text = self.Container.Visible and "▼" or "▲"
    end)

    return self
end

return Section
