local Library = {}

local GeneralModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Modules/Universal/General.luau"))()

local WS = GeneralModule:Service("Workspace")
local CoreGui = (gethui and gethui() or GeneralModule:Service("CoreGui"))
function Library:MakeWindow(Config)
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
    Parent = CoreGui
  })
  s:SetAttribute("ZynLib", true)
  
  local Window = GeneralModule:new("Frame", {
    Name = GenerateRandomName(999),
    Size = UDim2.new(0, (GetViewportSize().X / 1.6), 0, (GetViewportSize().X / 2.2)),
    Position = UDim2.new(-0.25, (GetViewportSize().X / 2.2), -0.50, (GetViewportSize().Y / 2.4)),
    BackgroundColor3 = Color3.fromRGB(8, 9, 12),
    Active = true,
    Draggable = true,
    Parent = s
  })
  GeneralModule:new("UIStroke", {
    Name = GenerateRandomName(999),
    Color = Color3.fromRGB(70, 60, 95),
    Parent = Window
  })
end

return Library
