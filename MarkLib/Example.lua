local MarkLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MarkLib/Source.luau"))()

local Win = MarkLib:Window({
  Title = "Mark Hub",
  SubTitle = "v1.0",
  RTitle = false, -- Rainbow title
  Drag = true,
  Resizable = true,
  Size = {
    Def = UDim2.new(0, 500, 0, 360),
    Min = UDim2.new(0, 320, 0, 220),
    Max = UDim2.new(0, 800, 0, 600)
  },
  SaveConfig = true,
  SaveFolder = "MarkHub",
  SaveFile = "config.json"
})

Win:OnUnload(function()
  print("[MarkHub] UI destruída.")
end)

Win:OnState(false, function()
  print("[MarkHub] UI fechada.")
end)

Win:OnState(true, function()
  print("[MarkHub] UI aberta.")
end)

local combatTab = Win:MakeTab({
  Title = "Combat",
  Icon = 6031302798
})

local combatSection = combatTab:Section({
  Title = "Auto Combat",
  Icon = 6031302798
})

local autoClickToggle = combatSection:Toggle({
  Title = "Auto Clicker",
  Desc = "Clica automaticamente no alvo.",
  Def = false,
  Flag = "AutoClicker",
  Callback = function(v)
    print("[Combat] Auto Clicker:", v)
  end
})

local aimbotToggle = combatSection:Toggle({
  Title = "Aimbot",
  Desc = "Mira automaticamente nos inimigos.",
  Def = false,
  Flag = "Aimbot",
  Callback = function(v)
    print("[Combat] Aimbot:", v)
  end
})

local killButton = combatSection:Button({
  Title = "Kill Aura",
  Desc = "Ataca todos os inimigos próximos.",
  Callback = function()
    print("[Combat] Kill Aura ativado.")
  end
})

local resetButton = combatSection:Button({
  Title = "Reset Target",
  Desc = "Reseta o alvo atual.",
  Callback = function()
    print("[Combat] Target resetado.")
  end
})

local extraSection = combatTab:Section({
  Title = "Extra"
})

local antiKbToggle = extraSection:Toggle({
  Title = "Anti Knockback",
  Desc = "Previne knockback do personagem.",
  Def = false,
  Flag = "AntiKB",
  Callback = function(v)
    print("[Combat] Anti Knockback:", v)
  end
})

local godModeToggle = extraSection:Toggle({
  Title = "God Mode",
  Desc = "Torna o personagem invencível.",
  Def = false,
  Flag = "GodMode",
  Callback = function(v)
    print("[Combat] God Mode:", v)
  end
})

local movTab = Win:MakeTab({
  Title = "Movement",
  Icon = 6034684950
})

local movSection = movTab:Section({
  Title = "Speed",
  Icon = 6034684950
})

local speedToggle = movSection:Toggle({
  Title = "Speed Hack",
  Desc = "Aumenta a velocidade de movimento.",
  Def = false,
  Flag = "SpeedHack",
  Callback = function(v)
    print("[Movement] Speed Hack:", v)
    if v then
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    else
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
  end
})

local noclipToggle = movSection:Toggle({
  Title = "NoClip",
  Desc = "Atravessa paredes e objetos.",
  Def = false,
  Flag = "NoClip",
  Callback = function(v)
    print("[Movement] NoClip:", v)
  end
})

local tpButton = movSection:Button({
  Title = "Teleport to Spawn",
  Desc = "Teleporta ao ponto de spawn.",
  Callback = function()
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
      hrp.CFrame = CFrame.new(0, 5, 0)
      print("[Movement] Teleportado ao spawn.")
    end
  end
})

local flySection = movTab:Section({
  Title = "Flight"
})

local flyToggle = flySection:Toggle({
  Title = "Fly",
  Desc = "Permite voar livremente.",
  Def = false,
  Flag = "Fly",
  Callback = function(v)
    print("[Movement] Fly:", v)
  end
})

local infiniteJumpToggle = flySection:Toggle({
  Title = "Infinite Jump",
  Desc = "Permite pular infinitamente.",
  Def = false,
  Flag = "InfiniteJump",
  Callback = function(v)
    print("[Movement] Infinite Jump:", v)
  end
})

local resetPosButton = flySection:Button({
  Title = "Reset Position",
  Desc = "Reseta a posição do personagem.",
  Callback = function()
    print("[Movement] Posição resetada.")
  end
})

local miscTab = Win:MakeTab({
  Title = "Misc",
  Icon = 6031302784
})

local utilSection = miscTab:Section({
  Title = "Utilities"
})

local espToggle = utilSection:Toggle({
  Title = "ESP",
  Desc = "Mostra jogadores através de paredes.",
  Def = false,
  Flag = "ESP",
  Callback = function(v)
    print("[Misc] ESP:", v)
  end
})

local chatToggle = utilSection:Toggle({
  Title = "Chat Bypass",
  Desc = "Bypassa o filtro de chat.",
  Def = false,
  Flag = "ChatBypass",
  Callback = function(v)
    print("[Misc] Chat Bypass:", v)
  end
})

local rejoinButton = utilSection:Button({
  Title = "Rejoin",
  Desc = "Entra novamente no servidor.",
  Callback = function()
    print("[Misc] Rejoining...")
    game:GetService("TeleportService"):Teleport(game.PlaceId)
  end
})

local serverHopButton = utilSection:Button({
  Title = "Server Hop",
  Desc = "Troca para outro servidor.",
  Callback = function()
    print("[Misc] Server hopping...")
  end
})

local devSection = miscTab:Section({
  Title = "Developer"
})

local debugToggle = devSection:Toggle({
  Title = "Debug Mode",
  Desc = "Ativa logs de debug no console.",
  Def = false,
  Flag = "Debug",
  Callback = function(v)
    print("[Misc] Debug Mode:", v)
  end
})

local unloadButton = devSection:Button({
  Title = "Unload Script",
  Desc = "Descarrega o script completamente.",
  Callback = function()
    Win:Unload()
  end
})

task.delay(5, function()
  speedToggle:SetTitle("Speed Hack (Editado)")
  speedToggle:SetDesc("Velocidade alterada para 100.")
  speedToggle:SetCallback(function(v)
    if v then
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    else
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
  end)

  tpButton:SetTitle("Teleport to Baseplate")
  tpButton:SetDesc("Teleporta para o centro do mapa.")
  tpButton:SetCallback(function()
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(0, 5, 0) end
  end)

  print("[MarkHub] Elementos atualizados dinamicamente.")
end)
