local Window = {}
Window.__index = Window
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Parent = self.ScreenGui
    })
    New("UICorner", {CornerRadius = UDim.new(0, 12), Parent = self.Main})
    
    local Border = New("UIStroke", {
        Color = self.Theme.Outline,
        Thickness = 1.8,
        Parent = self.Main
    })
    local BorderGrad = New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, self.Theme.Accent),
            ColorSequenceKeypoint.new(0.5, self.Theme.Outline),
            ColorSequenceKeypoint.new(1, self.Theme.Accent)
        }),
        Parent = Border
    })

    task.spawn(function()
        while task.wait() do BorderGrad.Rotation = BorderGrad.Rotation + 1 end
    end)

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
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    RunService.RenderStepped:Connect(function()
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

function Window:Tab(data)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Tab.lua"))().new(self, data)
end

function Window:Unload() self.ScreenGui:Destroy() end

return Window
