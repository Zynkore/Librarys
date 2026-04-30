local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")

return {
    new = function(parent, data)
        local Theme = parent.Theme
        local Target = parent.Container or parent.Page
        
        local Frame = New("TextButton", {
            Parent = Target,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.3,
            Text = "",
            AutoButtonColor = false
        })
        New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Frame})
        local Stroke = New("UIStroke", {Color = Theme.Outline, Thickness = 1, Transparency = 0.5, Parent = Frame})
        
        local Label = New("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = data.Name,
            TextColor3 = Theme.SubText,
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            Parent = Frame
        })

        Frame.MouseEnter:Connect(function()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0, Color = Theme.Accent}):Play()
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Theme.Text}):Play()
        end)
        Frame.MouseLeave:Connect(function()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.5, Color = Theme.Outline}):Play()
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Theme.SubText}):Play()
        end)
        Frame.MouseButton1Down:Connect(function()
            TweenService:Create(Frame, TweenInfo.new(0.1), {Size = UDim2.new(1, -4, 0, 30)}):Play()
        end)
        Frame.MouseButton1Up:Connect(function()
            TweenService:Create(Frame, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 32)}):Play()
            if data.Callback then data.Callback() end
        end)
        return Frame
    end
}
