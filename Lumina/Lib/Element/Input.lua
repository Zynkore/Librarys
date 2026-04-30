local Input = {}
Input.__index = Input
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")

function Input.new(parent, data)
    local self = setmetatable({}, Input)
    local Theme = parent.Theme
    local Target = parent.Container or parent.Page

    local Frame = New("Frame", {
        Name = "Input_" .. data.Name,
        Parent = Target,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0
    })
    New("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Frame})
    
    local Stroke = New("UIStroke", {
        Color = Theme.Outline,
        Thickness = 1,
        Transparency = 0.5,
        Parent = Frame
    })

    local Title = New("TextLabel", {
        Size = UDim2.new(0, 100, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        Text = data.Name,
        TextColor3 = Theme.SubText,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Parent = Frame
    })

    local BoxFrame = New("Frame", {
        Size = UDim2.new(1, -120, 0, 24),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme.Main,
        Parent = Frame
    })
    New("UICorner", {CornerRadius = UDim.new(0, 4), Parent = BoxFrame})
    local BoxStroke = New("UIStroke", {Color = Theme.Outline, Thickness = 1, Parent = BoxFrame})

    local TextBox = New("TextBox", {
        Size = UDim2.new(1, -10, 1, 0),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 1,
        Text = data.Placeholder or "Type here...",
        PlaceholderText = "",
        TextColor3 = Theme.SubText,
        PlaceholderColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        ClearTextOnFocus = false,
        Parent = BoxFrame
    })

    TextBox.Focused:Connect(function()
        TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Theme.Accent}):Play()
        TweenService:Create(TextBox, TweenInfo.new(0.2), {TextColor3 = Theme.Text}):Play()
    end)

    TextBox.FocusLost:Connect(function(enter)
        TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Theme.Outline}):Play()
        TweenService:Create(TextBox, TweenInfo.new(0.2), {TextColor3 = Theme.SubText}):Play()
        if data.Callback then
            data.Callback(TextBox.Text)
        end
    end)

    return self
end

return Input
