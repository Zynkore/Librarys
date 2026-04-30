local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()

return {
    new = function(parent, data)
        local Target = parent.Container or parent.Page
        return New("TextLabel", {
            Parent = Target,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = data.Name,
            TextColor3 = parent.Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end
}
