local Lumina = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/init.lua"))()

local Window = Lumina:Window({
    Title = "Lumina Lib",
    SubTitle = "Versão Básica",
    Theme = "Darker"
})

local Tab = Window:Tab({
    Name = "Inicio",
    Icon = ""
})

Tab:Label({
    Name = "Bem-vindo a Lumina Library!"
})
