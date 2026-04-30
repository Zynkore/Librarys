local Section = {}
Section.__index = Section
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()

function Section.new(tab, data)
    local self = setmetatable({}, Section)
    
    local Group = New("Frame", {
        Name = data.Name .. "_Section",
        Parent = tab.Page,
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    })

    local Header = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = tab.Theme.Section,
        BackgroundTransparency = 0.4,
        Text = "",
        AutoButtonColor = false,
        Parent = Group
    })
    
    New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Header})
    New("UIStroke", {Color = tab.Theme.Outline, Thickness = 0.8, Parent = Header})
    
    New("Frame", {
        Size = UDim2.new(0, 2, 0, 14),
        Position = UDim2.new(0, 8, 0.5, -7),
        BackgroundColor3 = tab.Theme.Accent,
        BorderSizePixel = 0,
        Parent = Header
    })

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 18, 0, 0),
        Text = data.Name,
        TextColor3 = tab.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Parent = Header
    })

    local Arrow = New("TextLabel", {
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(1, -32, 0, 0),
        Text = "▼",
        TextColor3 = tab.Theme.SubText,
        TextSize = 10,
        BackgroundTransparency = 1,
        Parent = Header
    })

    local Content = New("Frame", {
        Name = "Content",
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 36),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Visible = true,
        Parent = Group
    })
    
    New("UIListLayout", {Padding = UDim.new(0, 6), Parent = Content})

    Header.MouseButton1Click:Connect(function()
        Content.Visible = not Content.Visible
        Arrow.Text = Content.Visible and "▼" or "▲"
    end)

    self.Container = Content
    self.Theme = tab.Theme
    return self
end

return Section
