# KeyLib ( By me )

### Load `Lib`
```luau
local KeyLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/seu/repo/main/KeyLib.lua'))()
```

### Settings
```luau
KeyLib:KeySystem({
  Title = "Script",
  SubTitle = "Entre com sua key para continuar.",
  KeyC = {
    Key = "2026",
    Link = "https://discord.gg/server",
    LoadCode = [[
      print("Script carregado!")
    ]]
  },
  SaveSettings = true,
  SaveFolder = "Script",
  SaveFile = "key.txt"
})
```
