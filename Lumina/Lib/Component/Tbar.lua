local Tbar = {}

function Tbar.new(parent, data)
    local Theme = parent.Theme
    
    local Frame = Instance.new("Frame")
    Frame.Name = "Tbar"
    Frame.Size = UDim2.new(1, 0, 0, 35)
    Frame.BackgroundColor3 = Theme.Tbar
    Frame.BorderSizePixel = 0
    Frame.Parent = parent.Main
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame
    
    local FixCorner = Instance.new("Frame")
    FixCorner.Size = UDim2.new(1, 0, 0, 10)
    FixCorner.Position = UDim2.new(0, 0, 1, -10)
    FixCorner.BackgroundColor3 = Theme.Tbar
    FixCorner.BorderSizePixel = 0
    FixCorner.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = data.Title
    Title.TextColor3 = Theme.Text
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame
    
    return Frame
end

return Tbar
