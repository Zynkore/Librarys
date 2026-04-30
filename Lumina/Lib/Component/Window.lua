local Window = {}
Window.__index = Window
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local UserInputService = game:GetService("UserInputService")

function Window.new(data)
    local self = setmetatable({}, Window)
    self.Theme = data.Theme
    
    self.ScreenGui = New("ScreenGui", {
        Name = "Lumina_" .. math.random(100, 999),
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false
    })
    
    self.Main = New("Frame", {
        Name = "Main",
        Size = UDim2.new(0, 480, 0, 320),
        Position = UDim2.new(0.5, -240, 0.5, -160),
        BackgroundColor3 = self.Theme.Main,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = self.ScreenGui
    })
    
    New("UICorner", {CornerRadius = UDim.new(0, 10), Parent = self.Main})
    
    local Stroke = New("UIStroke", {
        Color = self.Theme.Outline,
        Thickness = 1.6,
        Parent = self.Main
    })
    
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, self.Theme.Accent),
            ColorSequenceKeypoint.new(1, self.Theme.Outline)
        }),
        Rotation = 45,
        Parent = Stroke
    })

    local GlowLine = New("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        Parent = self.Main
    })
    
    New("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(1, 1)
        }),
        Parent = GlowLine
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

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
            self.Main.Visible = not self.Main.Visible
        end
    end)
    
    return self
end

function Window:Unload()
    self.ScreenGui:Destroy()
end

function Window:Tab(data)
    local TabModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Tab.lua"))()
    return TabModule.new(self, data)
end

return Window
