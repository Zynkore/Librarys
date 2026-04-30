local Lumina = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/init.lua"))()

local Window = Lumina:Window({
    Title = "Lumina Premium",
    SubTitle = "Build: 1.0.2",
    Theme = "Purple"
})

local Tab = Window:Tab({
    Name = "Combat",
    Icon = "rbxassetid://1234567"
})

local SectionLeft = Tab:Section({
    Name = "Main Features",
    Side = "Left"
})

SectionLeft:Label({
    Name = "Status: Protegido"
})

local SectionRight = Tab:Section({
    Name = "Visuals",
    Side = "Right"
})

SectionRight:Label({
    Name = "FPS: 60"
})

local SettingsTab = Window:Tab({
    Name = "Config",
    Icon = ""
})

SettingsTab:Label({
    Name = "Ajustes de Interface"
})
