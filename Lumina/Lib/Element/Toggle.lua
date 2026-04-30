local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")

return {
    new = function(parent, data)
        local Theme = parent.Theme
        local Target = parent.Container or parent.Page
        local Toggled = false
        
        local Frame = New("TextButton", {
            Parent = Target,
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.4,
            Text = "",
            AutoButtonColor = false
        })
        New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Frame})
        
        local Label = New("TextLabel", {
            Size = UDim2.new(1, -50, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            Text = data.Name,
            TextColor3 = Theme.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent = Frame
        })

        local Box = New("Frame", {
            Size = UDim2.new(0, 34, 0, 18),
            Position = UDim2.new(1, -44, 0.5, -9),
            BackgroundColor3 = Theme.Main,
            Parent = Frame
        })
        New("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Box})
        local Stroke = New("UIStroke", {Color = Theme.Outline, Thickness = 1.2, Parent = Box})
        
        local Dot = New("Frame", {
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(0, 3, 0.5, -6),
            BackgroundColor3 = Theme.SubText,
            Parent = Box
        })
        New("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Dot})

        Frame.MouseButton1Click:Connect(function()
            Toggled = not Toggled
            TweenService:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Position = Toggled and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
                BackgroundColor3 = Toggled and Theme.Accent or Theme.SubText
            }):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Toggled and Theme.Accent or Theme.Outline}):Play()
            TweenService:Create(Label, TweenInfo.new(0.2), {TextColor3 = Toggled and Theme.Text or Theme.SubText}):Play()
            if data.Callback then data.Callback(Toggled) end
        end)
        return Frame
    end
}
