local KeyLib = {}

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do k[pp] = v end
  return k
end

local function makeDraggable(obj, handle)
  local dragging, dragStart, startPos = false, nil, nil
  handle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = obj.Position
    end
  end)
  UIS.InputChanged:Connect(function(input)
    if dragging and (
      input.UserInputType == Enum.UserInputType.MouseMovement
      or input.UserInputType == Enum.UserInputType.Touch
    ) then
      local delta = input.Position - dragStart
      local vp = workspace.CurrentCamera.ViewportSize
      local size = obj.AbsoluteSize
      obj.Position = UDim2.new(0,
        math.clamp(startPos.X.Offset + delta.X, 0, vp.X - size.X), 0,
        math.clamp(startPos.Y.Offset + delta.Y, 0, vp.Y - size.Y)
      )
    end
  end)
  UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
      dragging = false
    end
  end)
end

local function resolveKey(k)
  if type(k) ~= "string" then return nil end
  if k:sub(1, 4) == "http" then
    local ok, res = pcall(game.HttpGet, game, k)
    return ok and res:gsub("%s+", "") or nil
  end
  return k
end

local function runCode(code)
  if type(code) == "function" then
    code()
  elseif type(code) == "string" then
    local ok, err = pcall(loadstring(code))
    if not ok then warn("[KeyLib] " .. tostring(err)) end
  end
end

local function savePath(folder, file)
  return folder .. "/" .. file
end

local function writeKey(folder, file, key)
  pcall(function()
    if not isfolder(folder) then makefolder(folder) end
    writefile(savePath(folder, file), key)
  end)
end

local function readKey(folder, file)
  local ok, res = pcall(function()
    local path = savePath(folder, file)
    if isfolder(folder) and isfile(path) then
      return readfile(path):gsub("%s+", "")
    end
  end)
  return ok and res or nil
end

function KeyLib:KeySystem(cfg)
  local title   = cfg.Title or "Key System"
  local sub     = cfg.SubTitle or "Enter your key to continue."
  local keyC    = cfg.KeyC or {}
  local valid   = resolveKey(keyC.Key)
  local link    = keyC.Link or ""
  local code    = keyC.LoadCode
  local save    = cfg.SaveSettings == true
  local folder  = cfg.SaveFolder or "KeyLib"
  local file    = cfg.SaveFile or "key.txt"

  if save then
    local saved = readKey(folder, file)
    if saved and saved == valid then
      runCode(code)
      return
    end
  end

  local gui = new("ScreenGui", {
    Name = "KeyLibGui",
    ResetOnSpawn = false,
    Parent = game.CoreGui
  })

  local bg = new("Frame", {
    Parent = gui,
    BackgroundColor3 = Color3.fromRGB(18, 18, 20),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0)
  })

  local card = new("Frame", {
    Parent = bg,
    BackgroundColor3 = Color3.fromRGB(30, 30, 33),
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 300, 0, 220)
  })
  new("UICorner", { Parent = card, CornerRadius = UDim.new(0, 20) })
  new("UIStroke", { Parent = card, Color = Color3.fromRGB(55, 55, 60), Thickness = 1 })
  makeDraggable(card, card)

  local iconBox = new("Frame", {
    Parent = card,
    BackgroundColor3 = Color3.fromRGB(45, 45, 50),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 16, 0, 16),
    Size = UDim2.new(0, 52, 0, 52)
  })
  new("UICorner", { Parent = iconBox, CornerRadius = UDim.new(0, 13) })

  local iconLabel = new("TextLabel", {
    Parent = iconBox,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Text = "○",
    TextColor3 = Color3.fromRGB(160, 160, 165),
    TextSize = 24,
    Font = Enum.Font.GothamBold
  })

  new("TextLabel", {
    Parent = card,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 16, 0, 80),
    Size = UDim2.new(1, -32, 0, 28),
    Text = title,
    TextColor3 = Color3.fromRGB(235, 235, 240),
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
  })

  new("TextLabel", {
    Parent = card,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 16, 0, 110),
    Size = UDim2.new(1, -32, 0, 18),
    Text = sub,
    TextColor3 = Color3.fromRGB(115, 115, 120),
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
  })

  local keyBox = new("TextBox", {
    Parent = card,
    BackgroundColor3 = Color3.fromRGB(42, 42, 47),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 16, 0, 136),
    Size = UDim2.new(1, -32, 0, 32),
    PlaceholderText = "Digite sua key...",
    PlaceholderColor3 = Color3.fromRGB(90, 90, 95),
    Text = "",
    TextColor3 = Color3.fromRGB(220, 220, 225),
    TextSize = 13,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false
  })
  new("UICorner", { Parent = keyBox, CornerRadius = UDim.new(0, 8) })
  new("UIStroke", { Parent = keyBox, Color = Color3.fromRGB(60, 60, 65), Thickness = 1 })
  new("UIPadding", { Parent = keyBox, PaddingLeft = UDim.new(0, 10) })

  local status = new("TextLabel", {
    Parent = card,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 16, 0, 174),
    Size = UDim2.new(1, -32, 0, 14),
    Text = "",
    TextColor3 = Color3.fromRGB(200, 80, 80),
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
  })

  local confirmBtn = new("TextButton", {
    Parent = bg,
    BackgroundColor3 = Color3.fromRGB(50, 50, 57),
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -60),
    Size = UDim2.new(0, 300, 0, 42),
    Text = "Confirmar",
    TextColor3 = Color3.fromRGB(170, 170, 175),
    TextSize = 15,
    Font = Enum.Font.GothamBold
  })
  new("UICorner", { Parent = confirmBtn, CornerRadius = UDim.new(0, 22) })

  local getKeyBtn = new("TextButton", {
    Parent = bg,
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -22),
    Size = UDim2.new(0, 300, 0, 18),
    Text = "Get Key",
    TextColor3 = Color3.fromRGB(90, 130, 210),
    TextSize = 12,
    Font = Enum.Font.Gotham
  })

  task.spawn(function()
    local chars = {"○","◔","◑","◕","●"}
    local i = 1
    while gui.Parent do
      task.wait(0.15)
      if iconLabel and iconLabel.Parent then
        iconLabel.Text = chars[i]
        i = i % #chars + 1
      end
    end
  end)

  getKeyBtn.MouseButton1Down:Connect(function()
    if link ~= "" then
      setclipboard(link)
      getKeyBtn.Text = "Link copiado!"
      task.wait(2)
      getKeyBtn.Text = "Get Key"
    end
  end)

  confirmBtn.MouseButton1Down:Connect(function()
    local input = keyBox.Text:gsub("%s+", "")
    if input == "" then
      status.TextColor3 = Color3.fromRGB(200, 80, 80)
      status.Text = "⚠ Digite uma key."
      return
    end
    status.TextColor3 = Color3.fromRGB(160, 160, 165)
    status.Text = "Verificando..."
    confirmBtn.Text = "Aguarde..."
    task.wait(0.8)
    if valid and input == valid then
      status.TextColor3 = Color3.fromRGB(80, 200, 100)
      status.Text = "✓ Key válida!"
      confirmBtn.Text = "Carregando..."
      if save then writeKey(folder, file, input) end
      task.wait(0.6)
      gui:Destroy()
      runCode(code)
    else
      status.TextColor3 = Color3.fromRGB(200, 80, 80)
      status.Text = "✗ Key inválida."
      confirmBtn.Text = "Confirmar"
    end
  end)
end

return KeyLib
