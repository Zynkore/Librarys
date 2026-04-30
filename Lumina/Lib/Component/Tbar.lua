local Tbar = {}

function Tbar.new(window, data)
    local Frame = Instance.new("Frame")
    Frame.Name = "Tbar"
    Frame.Size = UDim2.new(1, 0, 0, 35)
    Frame.BackgroundColor3 = window.Theme.Tbar
    Frame.BorderSizePixel = 0
    Frame.Parent = window.Main
    
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = data.Title
    Title.TextColor3 = window.Theme.Text
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame
    
    local TabHolder = Instance.new("Frame")
    TabHolder.Name = "TabHolder"
    TabHolder.Size = UDim2.new(1, -10, 0, 20)
    TabHolder.Position = UDim2.new(0, 10, 1, 0)
    TabHolder.BackgroundTransparency = 1
    TabHolder.Parent = Frame
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = TabHolder
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.Padding = UDim.new(0, 5)
    
    return Frame
end

return Tbar
