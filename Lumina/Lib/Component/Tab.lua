local Tab = {}
Tab.__index = Tab
local New = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Utils/New.lua"))()
local TweenService = game:GetService("TweenService")

function Tab.new(window, data)
    local self = setmetatable({}, Tab)
    self.Window = window
    self.Theme = window.Theme
    
    local tbar = window.Main:WaitForChild("Tbar")
    local holder = tbar:WaitForChild("TabHolder")
    
    self.Button = New("TextButton", {
        Parent = holder,
        Size = UDim2.new(0, 0, 1, -4),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = self.Theme.Secondary,
        BackgroundTransparency = 1,
        Text = data.Name,
        TextColor3 = self.Theme.SubText,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        AutoButtonColor = false
    })
    
    local Underline = New("Frame", {
        Size = UDim2.new(0, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, 2),
        BackgroundColor3 = self.Theme.Accent,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Parent = self.Button
    })

    self.Page = New("ScrollingFrame", {
        Name = data.Name .. "Page",
        Parent = window.Container,
        Size = UDim2.size(1, 0, 1, 0),
        Position = UDim2.new(0, 50, 0, 0),
        BackgroundTransparency = 1,
        Visible = false,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })

    New("UIListLayout", {
        Parent = self.Page,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    self.Button.MouseButton1Click:Connect(function()
        for _, v in pairs(window.Container:GetChildren()) do
            if v:IsA("ScrollingFrame") and v.Visible then
                TweenService:Create(v, TweenInfo.new(0.2), {Position = UDim2.new(0, -50, 0, 0), GroupTransparency = 1}):Play()
                task.delay(0.2, function() v.Visible = false end)
            end
        end
        
        self.Page.Visible = true
        self.Page.Position = UDim2.new(0, 50, 0, 0)
        self.Page.GroupTransparency = 1
        TweenService:Create(self.Page, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0}):Play()
        
        for _, btn in pairs(holder:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = self.Theme.SubText}):Play()
                TweenService:Create(btn:FindFirstChild("Frame"), TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 2), BackgroundTransparency = 1}):Play()
            end
        end
        TweenService:Create(self.Button, TweenInfo.new(0.2), {TextColor3 = self.Theme.Text}):Play()
        TweenService:Create(Underline, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 2), BackgroundTransparency = 0}):Play()
    end)

    if #window.Container:GetChildren() == 1 then
        self.Page.Visible = true
        self.Page.Position = UDim2.new(0, 0, 0, 0)
        Underline.Size = UDim2.new(1, 0, 0, 2)
        Underline.BackgroundTransparency = 0
        self.Button.TextColor3 = self.Theme.Text
    end

    return self
end

function Tab:Section(data)
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/Lib/Element/Section.lua"))().new(self, data)
end

return Tab
