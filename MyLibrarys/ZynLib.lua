local Library = {}

local GeneralModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Modules/Universal/General.luau"))()

local WS = GeneralModule:Service("Workspace")
local CoreGui = (gethui and gethui() or GeneralModule:Service("CoreGui"))
function Library:MakeWindow(Config)
  local Title = Config.Title or Config.Name or "Missing title"
  local StartMinimized = Config.StartMinimized or Config.startMinimized or Config.startminimized or Config.sm or Config.Sm or Config.SM or Config.sM or false
  local UICorner = Config.UICorner or Config.UiCorner or Config.uiCorner or Config.uicorner or false
  local CornerRadius = Config.CornerRadius or Config.cornerRadius or Config.cornerradius or UDim.new(0, 6)
  for _, Obj in pairs(CoreGui:GetChildren()) do
    if Obj:GetAttribute("ZynLib") == true then
      Obj:Destroy()
    end
  end
  function GetViewportSize()
    return WS.CurrentCamera.ViewportSize
  end
  function GenerateRandomName(Size)
    local EncodeChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@#$_&-+()/*':;!?,.~`|•√π÷×§∆£¢€¥^°={}\%©®™✓[]<>"
    local Result = ""
    for i = 1, Size do
      local Index = math.random(1, #EncodeChars)
      Result ..= EncodeChars:sub(Index, Index)
    end
    return Result
  end
  local s = GeneralModule:new("ScreenGui", {
    Name = GenerateRandomName(999),
    DisplayOrder = math.huge,
    IgnoreGuiInset = true,
    Parent = CoreGui
  })
  s:SetAttribute("ZynLib", true)
  
  local Window = GeneralModule:new("Frame", {
    Name = GenerateRandomName(999),
    Size = UDim2.new(0, (GetViewportSize().X / 1.6), 0, (GetViewportSize().Y / 1.1)),
    Position = UDim2.new(0, (GetViewportSize().X - (GetViewportSize().X / 1.6)) / 2, 0, (GetViewportSize().Y - (GetViewportSize().Y / 1.1)) / 2.3),
    BackgroundColor3 = Color3.fromRGB(8, 9, 12),
    BorderColor3 = Color3.fromRGB(9, 59, 164),
    Active = true,
    Draggable = true,
    Parent = s
  })
  if UICorner == true then
    GeneralModule:new("UICorner", {
      Name = GenerateRandomName(999),
      CornerRadius = CornerRadius,
      Parent = Window
    })
    GeneralModule:new("UIStroke", {
      Name = GenerateRandomName(999),
      Color = Color3.fromRGB(9, 59, 164),
      Thickness = 3,
      Parent = Window
    })
  end
  
  local TitleBar = GeneralModule:new("Frame", {
    Name = GenerateRandomName(999),
    Size = UDim2.new(0, Window.AbsoluteSize.X, 0, 35),
    BackgroundColor3 = Color3.fromRGB(8, 9, 12),
    BorderColor3 = Color3.fromRGB(9, 59, 164),
    Parent = Window
  })
  if UICorner == true then
    GeneralModule:new("UICorner", {
      Name = GenerateRandomName(999),
      BottomLeftRadius = UDim.new(0, 0),
      BottomRightRadius = UDim.new(0, 0),
      TopLeftRadius = CornerRadius,
      TopRightRadius = CornerRadius,
      Parent = TitleBar
    })
    GeneralModule:new("UIStroke", {
      Name = GenerateRandomName(999),
      Color = Color3.fromRGB(9, 59, 164),
      Thickness = 3,
      Parent = TitleBar
    })
  end
  
  local MinimizeButtonSizeY = 0
  local IsWindowMinimized = StartMinimized
  local MinimizeButton = GeneralModule:new("ImageButton", {
    Name = GenerateRandomName(999),
    Position = UDim2.new(0, TitleBar.AbsoluteSize.X - 53, 0, 1.25),
    Size = UDim2.new(0, 30, 0, TitleBar.AbsoluteSize.Y - 3),
    Image = "rbxassetid://10747384394",
    ImageColor3 = Color3.fromRGB(255, 255, 255),
    Parent = TitleBar
  })
  MinimizeButton.MouseButton1Click:Connect(function()
    IsWindowMinimized = not IsWindowMinimized
    if IsWindowMinimized then
      MinimizeButtonSizeY = tonumber(Window.AbsoluteSize.Y)
      Window.Size = UDim2.new(0, Window.AbsoluteSize.X, 0, TitleBar.AbsoluteSize.Y)
    else
      Window.Size = UDim2.new(0, Window.AbsoluteSize.X, 0, MinimizeButtonSizeY)
    end
  end)
  if IsWindowMinimized then
    MinimizeButtonSizeY = tonumber(Window.AbsoluteSize.Y)
    Window.Size = UDim2.new(0, Window.AbsoluteSize.X, 0, MinimizeButtonSizeY)
  end
  
  local CloseButton = GeneralModule:new("ImageButton", {
    Name = GenerateRandomName(999),
    Position = UDim2.new(0, TitleBar.AbsoluteSize.X - 38, 0, 1.25),
    Size = UDim2.new(0, 30, 0, TitleBar.AbsoluteSize.Y - 3),
    Image = "rbxassetid://10747384394",
    ImageColor3 = Color3.fromRGB(255, 255, 255),
    Parent = TitleBar
  })
end

return Library
