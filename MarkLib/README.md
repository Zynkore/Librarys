# Mark Lib

### Loading the `Lib`
```luau
local MarkLib = loadstring(game:HttpGet(''))()
```

### Create `window`
```luau
local Window = MarkLib:Window({
  Title = "Cool Hub!",
  SubTitle = "v1.0",
  Drag = true,
  Resizable = true,
  Size = {
    Def = UDim2.new(0, 500, 0, 360),
    Min = UDim2.new(0, 300, 0, 200),
    Max = UDim2.new(0, 800, 0, 600)
  }
  SaveConfig = true,
  SaveFolder = "HelloBro",
  SaveFile = "config.txt",
})
```

### Create `tab`
```luau
local Tab = Window:MakeTab({
  Title = "Cool tab",
  Icon = nil
})
```

### Full example
```luau
local MarkLib = loadstring(game:HttpGet(''))()

local Window = MarkLib:Window({
  Title = "Cool Hub!",
  SubTitle = "v1.0",
  Drag = true,
  Resizable = true,
  Size = {
    Def = UDim2.new(0, 500, 0, 360),
    Min = UDim2.new(0, 300, 0, 200),
    Max = UDim2.new(0, 800, 0, 600)
  }
  SaveConfig = true,
  SaveFolder = "HelloBro",
  SaveFile = "config.txt",
})

local Tab1 = Window:MakeTab({
  Title = "Home",
  Icon = 6034509993
})

local Section = Tab1:Section({
  Title = "Functions",
  Icon = 6022668898
})

Section:Toggle({
  Title = "Auto Farm",
  Desc = "Hello!",
  Flag = "AutoFarm",
  Def = false,
  Callback = function(state)
    print("AutoFarm:", state)
  end
})

Section:Button({
  Title = "TP",
  Desc = "Teleport to spawn",
  Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
  end
})

local Tab2 = Window:MakeTab({ Title = "Config" })
