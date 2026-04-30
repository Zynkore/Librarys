local Section = {}
Section.__index = Section

function Section.new(tab, data)
    local self = setmetatable({}, Section)
    
    local Frame = Instance.new("Frame")
    Frame.Name = data.Name .. "Section"
    Frame.Parent = tab.Page
    Frame.Size = UDim2.new(1, 0, 0, 30)
    Frame.BackgroundColor3 = tab.Theme.Section
    Frame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = data.Name:upper()
    Title.TextColor3 = tab.Theme.Accent
    Title.TextSize = 10
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame

    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = tab.Page
    Container.Size = UDim2.new(1, 0, 0, 0)
    Container.BackgroundTransparency = 1
    
    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Container
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 5)
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y)
    end)

    self.Container = Container
    self.Theme = tab.Theme
    
    return self
end

return Section
