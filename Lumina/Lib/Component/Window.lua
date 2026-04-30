local Window = {}
Window.__index = Window

function Window.new(data)
    local self = setmetatable({}, Window)
    self.Theme = data.Theme
    
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Lumina_" .. math.random(100, 999)
    self.ScreenGui.Parent = game:GetService("CoreGui")
    self.ScreenGui.ResetOnSpawn = false
    
    self.Main = Instance.new("Frame")
    self.Main.Name = "Main"
    self.Main.Size = UDim2.new(0, 450, 0, 300)
    self.Main.Position = UDim2.new(0.5, -225, 0.5, -150)
    self.Main.BackgroundColor3 = self.Theme.Main
    self.Main.BorderSizePixel = 0
    self.Main.Parent = self.ScreenGui
    
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 8)
    
    local TbarModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Tbar.lua"))()
    self.Tbar = TbarModule.new(self, {Title = data.Title})
    
    self.Container = Instance.new("Frame")
    self.Container.Name = "Container"
    self.Container.Size = UDim2.new(1, -20, 1, -55)
    self.Container.Position = UDim2.new(0, 10, 0, 45)
    self.Container.BackgroundTransparency = 1
    self.Container.Parent = self.Main
    
    return self
end

function Window:Tab(data)
    local TabModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Tab.lua"))()
    return TabModule.new(self, data)
end

return Window
