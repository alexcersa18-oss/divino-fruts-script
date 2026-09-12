-- LOADER - Divino Fruts Script
-- Use: loadstring(game:HttpGet("https://raw.githubusercontent.com/alexcersa18-oss/divino-fruts-script/main/Loader.lua"))()

print("[⚔️ DIVINO FRUTS] Carregando script...")

local scriptUrl = "https://raw.githubusercontent.com/alexcersa18-oss/divino-fruts-script/main/main.lua"

pcall(function()
    loadstring(game:HttpGet(scriptUrl))()
end)

print("[⚔️ DIVINO FRUTS] Script carregado com sucesso!")