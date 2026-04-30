local Notify = {}

function Notify.new(data)
    local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Theme/Darker.lua"))()
    
    local Gui = game:GetService("CoreGui"):FindFirstChild("LuminaNotifications") or Instance.new("ScreenGui")
    Gui.Name = "LuminaNotifications"
    Gui.Parent = game:GetService("CoreGui")

    local Holder = Gui:FindFirstChild("Holder") or Instance.new("Frame")
    if not Gui:FindFirstChild("Holder") then
        Holder.Name = "Holder"
        Holder.Parent = Gui
        Holder.Size = UDim2.new(0, 300, 1, -40)
        Holder.Position = UDim2.new(1, -310, 0, 20)
        Holder.BackgroundTransparency = 1
        local Layout = Instance.new("UIListLayout")
        Layout.Parent = Holder
        Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        Layout.Padding = UDim.new(0, 10)
    end

    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(1, 0, 0, 60)
    Box.BackgroundColor3 = Theme.Secondary
    Box.Parent = Holder
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Box

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.Accent
    Stroke.Thickness = 1
    Stroke.Parent = Box

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -10, 0, 25)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.Text = data.Title
    Title.TextColor3 = Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Box

    local Content = Instance.new("TextLabel")
    Content.Size = UDim2.new(1, -10, 0, 20)
    Content.Position = UDim2.new(0, 10, 0, 30)
    Content.Text = data.Content
    Content.TextColor3 = Theme.SubText
    Content.Font = Enum.Font.Gotham
    Content.BackgroundTransparency = 1
    Content.TextXAlignment = Enum.TextXAlignment.Left
    Content.Parent = Box

    task.delay(data.Duration or 5, function()
        Box:Destroy()
    end)
end

return Notify
