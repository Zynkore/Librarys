local Tab = {}
Tab.__index = Tab

function Tab.new(window, data)
    local self = setmetatable({}, Tab)
    self.Window = window
    self.Theme = window.Theme
    
    local tbar = window.Main:WaitForChild("Tbar")
    local holder = tbar:WaitForChild("TabHolder")
    
    self.Button = Instance.new("TextButton")
    self.Button.Parent = holder
    self.Button.Size = UDim2.new(0, 70, 1, 0)
    self.Button.BackgroundColor3 = self.Theme.Secondary
    self.Button.Text = data.Name
    self.Button.TextColor3 = self.Theme.Text
    self.Button.Font = Enum.Font.GothamMedium
    self.Button.TextSize = 11
    Instance.new("UICorner", self.Button).CornerRadius = UDim.new(0, 4)

    self.Page = Instance.new("ScrollingFrame")
    self.Page.Name = data.Name .. "Page"
    self.Page.Parent = window.Container
    self.Page.Size = UDim2.new(1, 0, 1, 0)
    self.Page.BackgroundTransparency = 1
    self.Page.Visible = false
    self.Page.ScrollBarThickness = 0

    Instance.new("UIListLayout", self.Page).Padding = UDim.new(0, 5)

    self.Button.MouseButton1Click:Connect(function()
        for _, v in pairs(window.Container:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        self.Page.Visible = true
    end)

    if #window.Container:GetChildren() == 1 then self.Page.Visible = true end

    return self
end

function Tab:Section(data)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Element/Section.lua"))().new(self, data)
end

function Tab:Notify(data)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Component/Notify.lua"))().new(data)
end

return Tab
