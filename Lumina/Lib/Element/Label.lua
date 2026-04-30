local Label = {}

function Label.new(parent, data)
    local Theme = parent.Theme
    local Target = parent.Container or parent.Page

    local Frame = Instance.new("Frame")
    Frame.Name = "Label_" .. data.Name
    Frame.Size = UDim2.new(1, 0, 0, 25)
    Frame.BackgroundTransparency = 1
    Frame.Parent = Target

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -10, 1, 0)
    Text.Position = UDim2.new(0, 10, 0, 0)
    Text.BackgroundTransparency = 1
    Text.Text = data.Name
    Text.TextColor3 = Theme.Text
    Text.TextSize = 12
    Text.Font = Enum.Font.Gotham
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Frame

    return Frame
end

return Label
