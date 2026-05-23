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

### Functions
```lua
:Unload() -- Destroy the window
.onUnloaded(function(): void) -- Called before the window is unloaded / closed

:SetState(<boolean>) -- Set window visibility
:GetState(: boolean) -- Get window visibility

:SetNotificationsState(<boolean>) -- Set notification visibility
:GetNotificationsState(: boolean) -- Get notification visibility

:SetAcrylicBlurState(<boolean>) -- Set UI Blur enabled
:GetAcrylicBlurState(: boolean) -- Get UI Blur enabled

:SetUserInfoState(<boolean>) -- Show or redact user info
:GetUserInfoState(: boolean) -- Get User Info Visibility

:SetKeybind(<enum>) -- Set window visibility keybind

:SetSize(<UDim2>) -- Sets the UI size
:GetSize(: UDim2) -- Returns the current UI Size

:SetScale(<number>) -- Sets the scale of the UI, 1 is the 100& scale (default), 1.5 is 150% scale, 2 is 200%, you get it. ( This uses the UIScale instance, which has several engine bugs and can cause visual issues with certain elements.)
:GetScale(: number) -- Returns the current scale of the UI

:UpdateTitle(<string>)
:UpdateSubtitle(<string>)

.Settings : table -- Not everything may be updated, but Callback should be correct.
```
---

## 
