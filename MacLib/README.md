# MacLib Example

## Loading the `Ui Lib`
```lua
local MacLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MacLib/Source.lua'))()
```
### Functions
```lua
:Demo() -- Brings up a demo window

:SetFolder(<string> Folder) -- Sets the folder all configs are saved in.
:SaveConfig(<string> Path) -- Saves all element values to a file in the folder you set with :SetFolder(), you can ignore certain elements by setting their .IgnoreConfig to true, or simply not defining a flag.
:LoadConfig(<string> Path) -- Loads a config located at path.
:RefreshConfigList(: table) -- Returns a table of all saved config names ( eg. {"Legit.json", "Rage.json"} )
:LoadAutoLoadConfig() -- Loads the config the user selected to automatically load.
--// To insert a pre-made config section, reference the "Adding tabs" page.
```
---

## Creating `window`
```lua
local Window = MacLib:Window({
  Title = "Kuzu Hub",
  Subtitle = "Paid | V3.12",
  Size = UDim2.fromOffset(868, 650), -- if pc: 868, 650. if mobile: 800, 380
  DragStyle = 1, -- 1: Pc/Emulator User, 2: Mobile user
  DisabledWindowControls = {},
  ShowUserInfo = true,
  Keybind = Enum.KeyCode.RightControl,
  AcrylicBlur = true,
})
```

###
