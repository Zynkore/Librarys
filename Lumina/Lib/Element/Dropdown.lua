local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()

return {
    new = function(parent, data)
        local Theme = parent.Theme
        local Target = parent.Container or parent.Page
        local Opened = false
        
        local Group = New("Frame", {
            Parent = Target,
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        })
        local Main = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.4,
            Text = "",
            AutoButtonColor = false,
            Parent = Group
        })
        New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Main})
        
        local Title = New("TextLabel", {
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            Text = data.Name .. ": " .. (data.Default or "None"),
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Parent = Main
        })

        local Container = New("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(0, 0, 0, 38),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.6,
            Visible = false,
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = Group
        })
        New("UICorner", {Parent = Container})
        New("UIListLayout", {Padding = UDim.new(0, 2), Parent = Container})

        for _, v in pairs(data.Options or {}) do
            local Btn = New("TextButton", {
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                Text = v,
                TextColor3 = Theme.SubText,
                Font = Enum.Font.Gotham,
                TextSize = 11,
                Parent = Container
            })
            Btn.MouseButton1Click:Connect(function()
                Title.Text = data.Name .. ": " .. v
                Container.Visible = false
                Opened = false
                if data.Callback then data.Callback(v) end
            end)
        end

        Main.MouseButton1Click:Connect(function()
            Opened = not Opened
            Container.Visible = Opened
        end)
        return Group
    end
}
