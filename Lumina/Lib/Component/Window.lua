local Window = {}
Window.__index = Window
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Window.new(data)
    local self = setmetatable({}, Window)
    self.Theme = data.Theme
    
    self.ScreenGui = New("ScreenGui", {
        Name = "Lumina_" .. math.random(100, 999),
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false,
        DisplayOrder = 10
    })
    
    self.Main = New("Frame", {
        Name = "Main",
        Size = UDim2.new(0, 480, 0, 320),
        Position = UDim2.new(0.5, -240, 0.5, -160),
        BackgroundColor3 = self.Theme.Main,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = self.ScreenGui
    })
    
    New("UICorner", {CornerRadius = UDim.new(0, 12), Parent = self.Main})
    
    local Border = New("UIStroke", {
        Color = self.Theme.Outline,
        Thickness = 1.8,
        Parent = self.Main
    })
    
    local BorderGradient = New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, self.Theme.Accent),
            ColorSequenceKeypoint.new(0.5, self.Theme.Outline),
            ColorSequenceKeypoint.new(1, self.Theme.Accent)
        }),
        Parent = Border
    })

    task.spawn(function()
        while task.wait() do
            BorderGradient.Rotation = BorderGradient.Rotation + 1
        end
    end)

    local InnerGlow = New("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = self.Main
    })
    New("UICorner", {CornerRadius = UDim.new(0, 12), Parent = InnerGlow})
    New("UIStroke", {
        Color = self.Theme.Accent,
        Thickness = 2.5,
        Transparency = 0.8,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = InnerGlow
    })

    local TbarModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Tbar.lua"))()
    self.Tbar = TbarModule.new(self, {Title = data.Title})
    
    self.Container = New("Frame", {
        Name = "Container",
        Size = UDim2.new(1, -20, 1, -95),
        Position = UDim2.new(0, 10, 0, 85),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = self.Main
    })

    local dragging, dragInput, dragStart, startPos
    self.Tbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.Main.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            self.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return self
end

return Window
