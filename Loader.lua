-- LOADER - Divino Fruts Script
-- Use: loadstring(game:HttpGet("https://raw.githubusercontent.com/alexcersa18-oss/divino-fruts-script/main/Loader.lua"))()

print("[⚔️ DIVINO FRUTS] Carregando script...")
print("[⚔️ DIVINO FRUTS] Versão: 2.0 - Com Aimbot + ESP + Interface PC/Mobile")

local scriptUrl = "https://raw.githubusercontent.com/alexcersa18-oss/divino-fruts-script/main/main.lua"

pcall(function()
    loadstring(game:HttpGet(scriptUrl))()
end)

print("[⚔️ DIVINO FRUTS] ==========================================")
print("[⚔️ DIVINO FRUTS] Script carregado com sucesso!")
print("[⚔️ DIVINO FRUTS] Pressione F1 para abrir a interface")
print("[⚔️ DIVINO FRUTS] Pressione F2 para ativar/desativar")
print("[⚔️ DIVINO FRUTS] ==========================================")
