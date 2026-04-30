local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")

return {
    new = function(parent, data)
        local Theme = parent.Theme
        local Target = parent.Container or parent.Page
        
        local Frame = New("Frame", {
            Parent = Target,
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.4,
            BorderSizePixel = 0
        })
        New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Frame})
        
        local TextBox = New("TextBox", {
            Size = UDim2.new(1, -24, 0, 24),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Theme.Main,
            Text = data.Placeholder or data.Name,
            TextColor3 = Theme.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            Parent = Frame
        })
        New("UICorner", {Parent = TextBox})
        local Stroke = New("UIStroke", {Color = Theme.Outline, Parent = TextBox})

        TextBox.Focused:Connect(function() TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play() end)
        TextBox.FocusLost:Connect(function()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Theme.Outline}):Play()
            if data.Callback then data.Callback(TextBox.Text) end
        end)
        return Frame
    end
}
