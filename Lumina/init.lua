local Lumina = {}
Lumina.__index = Lumina
Lumina.Theme = "Darker"

local function Fetch(path)
    local url = "https://raw.githubusercontent.com/MarkhubOfc/Librarys/main/Lumina/" .. path .. ".lua"
    local s, code = pcall(game.HttpGet, game, url)
    if s then
        return loadstring(code)()
    end
    warn("Error loading: " .. path)
end

function Lumina:Window(data)
    local theme = Fetch("Lib/Theme/" .. (data.Theme or self.Theme))
    local window = Fetch("Lib/Component/Window")
    
    return window.new({
        Title = data.Title or "Lumina",
        Sub = data.SubTitle or "",
        Theme = theme
    })
end

return Lumina
