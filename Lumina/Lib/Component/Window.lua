local Window = {}
Window.__index = Window

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Window.new(data)
    local self = setmetatable({}, Window)
    
    self.Theme = data.Theme
    
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Lumina_" .. math.random(100, 999)
    self.ScreenGui.Parent = game:GetService("CoreGui")
    
    self.Main = Instance.new("Frame")
    self.Main.Name = "Main"
    self.Main.Size = UDim2.new(0, 500, 0, 350)
    self.Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    self.Main.BackgroundColor3 = self.Theme.Main
    self.Main.BorderSizePixel = 0
    self.Main.Parent = self.ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = self.Main
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = self.Theme.Outline
    Stroke.Thickness = 1
    Stroke.Parent = self.Main
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Container"
    self.Container.Size = UDim2.new(1, 0, 1, -35)
    self.Container.Position = UDim2.new(0, 0, 0, 35)
    self.Container.BackgroundTransparency = 1
    self.Container.Parent = self.Main
    
    return self
end

function Window:Tab(data)
    local TabModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Tab.lua"))()
    return TabModule.new(self, data)
end

return Window
