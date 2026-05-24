local MarkLib = {}
MarkLib.Flags = {}

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do k[pp] = v end
  return k
end

function saveCfg(folder, file, data)
  pcall(function()
    if not isfolder(folder) then makefolder(folder) end
    writefile(folder .. "/" .. file, data)
  end)
end

function readCfg(folder, file)
  local ok, res = pcall(function()
    local path = folder .. "/" .. file
    if isfolder(folder) and isfile(path) then
      return readfile(path)
    end
  end)
  return ok and res or nil
end

function makeDraggable(obj, handle)
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
      obj.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
    end
  end)
  UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
      dragging = false
    end
  end)
end

function makeResizable(win, minSize, maxSize)
  local handle = new("Frame", {
    Parent = win,
    BackgroundColor3 = Color3.fromRGB(70, 70, 80),
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, 0, 1, 0),
    Size = UDim2.new(0, 10, 0, 10),
    ZIndex = 20
  })
  new("UICorner", { Parent = handle, CornerRadius = UDim.new(0, 3) })

  local resizing, startMouse, startSize = false, nil, nil
  handle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
      resizing = true
      startMouse = input.Position
      startSize = win.AbsoluteSize
    end
  end)
  UIS.InputChanged:Connect(function(input)
    if resizing and (
      input.UserInputType == Enum.UserInputType.MouseMovement
      or input.UserInputType == Enum.UserInputType.Touch
    ) then
      local delta = input.Position - startMouse
      local newW = math.clamp(startSize.X + delta.X, minSize.X.Offset, maxSize.X.Offset)
      local newH = math.clamp(startSize.Y + delta.Y, minSize.Y.Offset, maxSize.Y.Offset)
      win.Size = UDim2.new(0, newW, 0, newH)
    end
  end)
  UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
      resizing = false
    end
  end)
end

function resolveIcon(icon)
  if type(icon) == "number" then return "rbxassetid://" .. icon end
  return icon or ""
end

function makeRow(parent, opts, h)
  local height = h or (opts.Desc and opts.Desc ~= "" and 46 or 34)
  local btn = new("TextButton", {
    Parent = parent,
    BackgroundColor3 = Color3.fromRGB(20, 20, 26),
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Size = UDim2.new(1, 0, 0, height),
    Text = "",
    LayoutOrder = #parent:GetChildren()
  })
  new("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 7) })

  new("TextLabel", {
    Parent = btn,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 0),
    Size = UDim2.new(1, -60, 0, opts.Desc and opts.Desc ~= "" and 26 or height),
    Text = opts.Title or "",
    TextColor3 = Color3.fromRGB(210, 210, 220),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = opts.Desc and opts.Desc ~= "" and Enum.TextYAlignment.Bottom or Enum.TextYAlignment.Center,
    Name = "TitleLabel"
  })

  if opts.Desc and opts.Desc ~= "" then
    new("TextLabel", {
      Parent = btn,
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 10, 0, 26),
      Size = UDim2.new(1, -60, 0, 16),
      Text = opts.Desc,
      TextColor3 = Color3.fromRGB(75, 75, 92),
      TextSize = 10,
      Font = Enum.Font.Gotham,
      TextXAlignment = Enum.TextXAlignment.Left,
      Name = "DescLabel"
    })
  end

  return btn
end

function MarkLib:Window(cfg)
  local title     = cfg.Title or "MarkLib"
  local subtitle  = cfg.SubTitle or ""
  local resizable = cfg.Resizable == true
  local drag      = cfg.Drag ~= false
  local rtitle    = cfg.RTitle ~= false
  local saveConf  = cfg.SaveConfig == true
  local folder    = cfg.SaveFolder or "MarkLib"
  local file      = cfg.SaveFile or "config.json"
  local sizeT     = cfg.Size or {}
  local defSize   = sizeT.Def or UDim2.new(0, 500, 0, 360)
  local minSize   = sizeT.Min or UDim2.new(0, 300, 0, 200)
  local maxSize   = sizeT.Max or UDim2.new(0, 800, 0, 600)

  local vp = workspace.CurrentCamera.ViewportSize
  local defX = (vp.X - defSize.X.Offset) / 2
  local defY = (vp.Y / 2.5) - (defSize.Y.Offset / 2)

  if saveConf then
    local saved = readCfg(folder, file)
    if saved then
      local x, y = saved:match("(-?%d+),(-?%d+)")
      if x and y then defX, defY = tonumber(x), tonumber(y) end
    end
  end

  local gui = new("ScreenGui", {
    Name = "MarkLibGui",
    ResetOnSpawn = false,
    Parent = game.CoreGui
  })

  local win = new("Frame", {
    Parent = gui,
    BackgroundColor3 = Color3.fromRGB(12, 12, 15),
    BorderSizePixel = 0,
    Position = UDim2.new(0, defX, 0, defY),
    Size = defSize,
    ClipsDescendants = true
  })
  new("UICorner", { Parent = win, CornerRadius = UDim.new(0, 10) })
  new("UIStroke", { Parent = win, Color = Color3.fromRGB(45, 45, 52), Thickness = 1 })

  local header = new("Frame", {
    Parent = win,
    BackgroundColor3 = Color3.fromRGB(16, 16, 20),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 38)
  })
  new("UICorner", { Parent = header, CornerRadius = UDim.new(0, 10) })
  new("Frame", {
    Parent = header,
    BackgroundColor3 = Color3.fromRGB(16, 16, 20),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 1, -8),
    Size = UDim2.new(1, 0, 0, 8)
  })
  new("UIStroke", { Parent = header, Color = Color3.fromRGB(45, 45, 52), Thickness = 1 })

  local titleLabel = new("TextLabel", {
    Parent = header,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 12, 0, 0),
    Size = UDim2.new(0.5, 0, 1, 0),
    Text = title,
    TextColor3 = Color3.fromRGB(230, 230, 235),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
  })

  if subtitle ~= "" then
    new("TextLabel", {
      Parent = header,
      BackgroundTransparency = 1,
      Position = UDim2.new(0.5, 0, 0, 0),
      Size = UDim2.new(0.5, -40, 1, 0),
      Text = subtitle,
      TextColor3 = Color3.fromRGB(80, 80, 95),
      TextSize = 11,
      Font = Enum.Font.Gotham,
      TextXAlignment = Enum.TextXAlignment.Right
    })
  end

  local closeBtn = new("TextButton", {
    Parent = header,
    BackgroundColor3 = Color3.fromRGB(180, 55, 55),
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Size = UDim2.new(0, 14, 0, 14),
    Text = "",
    ZIndex = 10
  })
  new("UICorner", { Parent = closeBtn, CornerRadius = UDim.new(1, 0) })

  local body = new("Frame", {
    Parent = win,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 38),
    Size = UDim2.new(1, 0, 1, -38)
  })

  local sidebar = new("Frame", {
    Parent = body,
    BackgroundColor3 = Color3.fromRGB(16, 16, 20),
    BorderSizePixel = 0,
    Size = UDim2.new(0, 110, 1, 0)
  })
  new("UIStroke", { Parent = sidebar, Color = Color3.fromRGB(40, 40, 48), Thickness = 1 })
  new("UIListLayout", {
    Parent = sidebar,
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 2)
  })
  new("UIPadding", {
    Parent = sidebar,
    PaddingTop = UDim.new(0, 6),
    PaddingBottom = UDim.new(0, 6)
  })

  local contentHolder = new("Frame", {
    Parent = body,
    BackgroundColor3 = Color3.fromRGB(14, 14, 18),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 110, 0, 0),
    Size = UDim2.new(1, -110, 1, 0)
  })

  if rtitle then
    task.spawn(function()
      local hue = 0
      while gui.Parent do
        hue = (hue + 0.004) % 1
        titleLabel.TextColor3 = Color3.fromHSV(hue, 0.6, 1)
        RS.Heartbeat:Wait()
      end
    end)
  end

  if drag then
    makeDraggable(win, header)
    if saveConf then
      win:GetPropertyChangedSignal("Position"):Connect(function()
        saveCfg(folder, file,
          tostring(win.Position.X.Offset) .. "," .. tostring(win.Position.Y.Offset)
        )
      end)
    end
  end

  if resizable then makeResizable(win, minSize, maxSize) end

  local Win = {}
  local listeners = {}
  local unloadCallbacks = {}
  local state = true
  local tabs = {}
  local activeTab = nil

  function fireListeners(s)
    for _, cb in ipairs(listeners) do
      if cb.state == s then
        if type(cb.code) == "function" then
          task.spawn(cb.code, s)
        elseif type(cb.code) == "string" then
          local ok, err = pcall(loadstring(cb.code), s)
          if not ok then warn("[MarkLib] OnState: " .. tostring(err)) end
        end
      end
    end
  end

  function setActiveTab(tabObj)
    if activeTab then
      activeTab.btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
      activeTab.btn.TextColor3 = Color3.fromRGB(110, 110, 125)
      activeTab.panel.Visible = false
    end
    activeTab = tabObj
    activeTab.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    activeTab.btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    activeTab.panel.Visible = true
  end

  function Win:MakeTab(opts)
    local tabTitle = opts.Title or "Tab"
    local tabIcon  = resolveIcon(opts.Icon)

    local btn = new("TextButton", {
      Parent = sidebar,
      BackgroundColor3 = Color3.fromRGB(20, 20, 25),
      BorderSizePixel = 0,
      AutoButtonColor = false,
      Size = UDim2.new(1, -8, 0, 30),
      Text = tabIcon ~= "" and "" or tabTitle,
      TextColor3 = Color3.fromRGB(110, 110, 125),
      TextSize = 12,
      Font = Enum.Font.GothamBold,
      LayoutOrder = #tabs + 1
    })
    new("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

    local btnTextLabel = nil

    if tabIcon ~= "" then
      new("ImageLabel", {
        Parent = btn,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 8, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        Image = tabIcon
      })
      btnTextLabel = new("TextLabel", {
        Parent = btn,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 28, 0, 0),
        Size = UDim2.new(1, -32, 1, 0),
        Text = tabTitle,
        TextColor3 = Color3.fromRGB(110, 110, 125),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
      })
    end

    local panel = new("ScrollingFrame", {
      Parent = contentHolder,
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      ScrollBarThickness = 2,
      ScrollBarImageColor3 = Color3.fromRGB(55, 55, 68),
      CanvasSize = UDim2.new(0, 0, 0, 0),
      Visible = false
    })
    new("UIPadding", {
      Parent = panel,
      PaddingTop = UDim.new(0, 6),
      PaddingLeft = UDim.new(0, 8),
      PaddingRight = UDim.new(0, 8),
      PaddingBottom = UDim.new(0, 6)
    })

    local panelLayout = new("UIListLayout", {
      Parent = panel,
      FillDirection = Enum.FillDirection.Vertical,
      SortOrder = Enum.SortOrder.LayoutOrder,
      Padding = UDim.new(0, 4)
    })

    panelLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
      panel.CanvasSize = UDim2.new(0, 0, 0, panelLayout.AbsoluteContentSize.Y + 10)
    end)

    local tabObj = { btn = btn, panel = panel }
    table.insert(tabs, tabObj)
    if #tabs == 1 then setActiveTab(tabObj) end

    btn.MouseButton1Down:Connect(function()
      setActiveTab(tabObj)
    end)

    local Tab = {}

    function Tab:Select()
      setActiveTab(tabObj)
    end

    function Tab:SetTitle(t)
      tabTitle = t
      if tabIcon == "" then
        btn.Text = t
      elseif btnTextLabel then
        btnTextLabel.Text = t
      end
    end

    function Tab:SetIcon(icon)
      tabIcon = resolveIcon(icon)
      local img = btn:FindFirstChildWhichIsA("ImageLabel")
      if img then img.Image = tabIcon end
    end

    function Tab:Section(opts)
      local sTitle = opts.Title or "Section"
      local sIcon  = resolveIcon(opts.Icon)

      local sFrame = new("TextButton", {
        Parent = panel,
        BackgroundColor3 = Color3.fromRGB(18, 18, 23),
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, 26),
        Text = "",
        LayoutOrder = #panel:GetChildren()
      })
      new("UICorner", { Parent = sFrame, CornerRadius = UDim.new(0, 7) })

      if sIcon ~= "" then
        new("ImageLabel", {
          Parent = sFrame,
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(0, 0.5),
          Position = UDim2.new(0, 8, 0.5, 0),
          Size = UDim2.new(0, 13, 0, 13),
          Image = sIcon
        })
      end

      new("TextLabel", {
        Parent = sFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, sIcon ~= "" and 26 or 10, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Text = sTitle:upper(),
        TextColor3 = Color3.fromRGB(75, 75, 90),
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
      })

      local sectionItems = new("Frame", {
        Parent = panel,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = #panel:GetChildren()
      })
      new("UIListLayout", {
        Parent = sectionItems,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4)
      })

      local Section = {}

      function Section:Toggle(o) return Tab:Toggle(o, sectionItems) end
      function Section:Button(o) return Tab:Button(o, sectionItems) end

      return Section
    end

    function Tab:Toggle(opts, customParent)
      local tState = opts.Def == true
      local flag   = opts.Flag
      local target = customParent or panel
      local cb     = opts.Callback

      if flag then MarkLib.Flags[flag] = tState end

      local row      = makeRow(target, opts)
      local titleLbl = row:FindFirstChild("TitleLabel")
      local descLbl  = row:FindFirstChild("DescLabel")

      local track = new("TextButton", {
        Parent = row,
        BackgroundColor3 = Color3.fromRGB(65, 65, 80),
        BorderSizePixel = 0,
        AutoButtonColor = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 17),
        Text = "",
        ZIndex = row.ZIndex + 1
      })
      new("UICorner", { Parent = track, CornerRadius = UDim.new(1, 0) })

      local thumb = new("Frame", {
        Parent = track,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 13, 0, 13),
        ZIndex = track.ZIndex + 1
      })
      new("UICorner", { Parent = thumb, CornerRadius = UDim.new(1, 0) })

      function updateVisual()
        track.BackgroundColor3 = tState and Color3.fromRGB(75, 175, 95) or Color3.fromRGB(65, 65, 80)
        thumb.Position = tState and UDim2.new(1, -15, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
        if flag then MarkLib.Flags[flag] = tState end
      end
      updateVisual()

      local function toggle()
        tState = not tState
        updateVisual()
        if cb then cb(tState) end
      end

      row.MouseButton1Down:Connect(toggle)
      track.MouseButton1Down:Connect(toggle)

      local Toggle = {}

      function Toggle:SetTitle(t)
        if titleLbl then titleLbl.Text = t end
      end

      function Toggle:SetDesc(d)
        if descLbl then
          descLbl.Text = d
        else
          new("TextLabel", {
            Parent = row,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 26),
            Size = UDim2.new(1, -60, 0, 16),
            Text = d,
            TextColor3 = Color3.fromRGB(75, 75, 92),
            TextSize = 10,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            Name = "DescLabel"
          })
          row.Size = UDim2.new(1, 0, 0, 46)
        end
      end

      function Toggle:SetValue(v)
        tState = v
        updateVisual()
        if cb then cb(tState) end
      end

      function Toggle:SetCallback(fn)
        cb = fn
      end

      return Toggle
    end

    function Tab:Button(opts, customParent)
      local target = customParent or panel
      local cb     = opts.Callback

      local row      = makeRow(target, opts)
      local titleLbl = row:FindFirstChild("TitleLabel")
      local descLbl  = row:FindFirstChild("DescLabel")

      new("TextLabel", {
        Parent = row,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 16, 0, 16),
        Text = "›",
        TextColor3 = Color3.fromRGB(70, 70, 85),
        TextSize = 18,
        Font = Enum.Font.GothamBold
      })

      row.MouseButton1Down:Connect(function()
        if cb then cb() end
      end)

      local Button = {}

      function Button:SetTitle(t)
        if titleLbl then titleLbl.Text = t end
      end

      function Button:SetDesc(d)
        if descLbl then
          descLbl.Text = d
        else
          new("TextLabel", {
            Parent = row,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 26),
            Size = UDim2.new(1, -60, 0, 16),
            Text = d,
            TextColor3 = Color3.fromRGB(75, 75, 92),
            TextSize = 10,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            Name = "DescLabel"
          })
          row.Size = UDim2.new(1, 0, 0, 46)
        end
      end

      function Button:SetCallback(fn)
        cb = fn
      end

      return Button
    end

    return Tab
  end

  function Win:OnUnload(code)
    table.insert(unloadCallbacks, code)
  end

  function Win:Unload()
    for _, code in ipairs(unloadCallbacks) do
      if type(code) == "function" then
        task.spawn(code)
      elseif type(code) == "string" then
        local ok, err = pcall(loadstring(code))
        if not ok then warn("[MarkLib] OnUnload: " .. tostring(err)) end
      end
    end
    gui:Destroy()
  end

  function Win:GetState()
    return state
  end

  function Win:SetState(s)
    state = s
    win.Visible = s
    fireListeners(s)
  end

  function Win:OnState(s, code)
    table.insert(listeners, { state = s, code = code })
  end

  closeBtn.MouseButton1Down:Connect(function()
    Win:SetState(false)
  end)

  return Win
end

function MarkLib:Demo()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MarkLib/Example.lua'))()
end

return MarkLib
