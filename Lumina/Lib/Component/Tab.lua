local Tab = {}
Tab.__index = Tab

local TweenService = game:GetService("TweenService")

function Tab.new(window, data)
    local self = setmetatable({}, Tab)
    
    self.Window = window
    self.Theme = window.Theme
    
    local tbar = window.Main:FindFirstChild("Tbar")
    local container = window.Main:FindFirstChild("Container")
    
    self.Button = Instance.new("TextButton")
    self.Button.Name = data.Name .. "Tab"
    self.Button.Parent = tbar
    self.Button.Size = UDim2.new(0, 100, 1, 0)
    self.Button.BackgroundColor3 = self.Theme.Accent
    self.Button.BackgroundTransparency = 1
    self.Button.Text = data.Name
    self.Button.TextColor3 = self.Theme.SubText
    self.Button.TextSize = 12
    self.Button.Font = Enum.Font.GothamMedium
    self.Button.BorderSizePixel = 0

    self.Page = Instance.new("ScrollingFrame")
    self.Page.Name = data.Name .. "Page"
    self.Page.Parent = container
    self.Page.Size = UDim2.new(1, -20, 1, -20)
    self.Page.Position = UDim2.new(0, 10, 0, 10)
    self.Page.BackgroundTransparency = 1
    self.Page.Visible = false
    self.Page.ScrollBarThickness = 2
    self.Page.ScrollBarImageColor3 = self.Theme.Accent
    self.Page.CanvasSize = UDim2.new(0, 0, 0, 0)

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = self.Page
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)

    self.Button.MouseButton1Click:Connect(function()
        for _, v in pairs(container:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end
        self.Page.Visible = true
    end)

    if #container:GetChildren() == 1 then
        self.Page.Visible = true
    end

    return self
end

function Tab:Section(data)
    local code = game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Element/Section.lua")
    local SectionModule = loadstring(code)()
    return SectionModule.new(self, data)
end

function Tab:Label(data)
    local code = game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Element/Label.lua")
    local LabelModule = loadstring(code)()
    return LabelModule.new(self, data)
end

return Tab
