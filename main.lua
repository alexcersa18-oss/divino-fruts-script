-- MAIN - Divino Fruts Script
-- Aimbot + ESP com interface Red-Z Hub Style

print("[⚔️ DIVINO FRUTS] Script iniciando...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ==================== CONFIGURAÇÕES ====================
local Config = {
    Enabled = true,
    AimbotEnabled = true,
    ESPEnabled = true,
    Platform = "PC", -- "PC" ou "MOBILE"
    AimbotSensitivity = 0.5,
    ESPDistance = 100,
    UIScale = 1,
}

-- ==================== DETECÇÃO DE PLATAFORMA ====================
local function detectPlatform()
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return "MOBILE"
    else
        return "PC"
    end
end

-- Detectar automaticamente ou permitir mudança manual
Config.Platform = detectPlatform()
print("[⚔️ DIVINO FRUTS] Plataforma detectada: " .. Config.Platform)

-- ==================== CRIAR INTERFACE ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DivinoFrutsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 100)
MainFrame.Parent = ScreenGui
MainFrame.Visible = true

-- Header
local Header = Instance.new("TextLabel")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 18
Header.Font = Enum.Font.GothamBold
Header.Text = "⚔️ DIVINO FRUTS"
Header.Parent = MainFrame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.Parent = Header

-- Info Label
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, -20, 0, 30)
InfoLabel.Position = UDim2.new(0, 10, 0, 60)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoLabel.TextSize = 14
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Text = "📱 Plataforma: " .. Config.Platform
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.Parent = MainFrame

-- Toggle Aimbot
local AimbotLabel = Instance.new("TextLabel")
AimbotLabel.Name = "AimbotLabel"
AimbotLabel.Size = UDim2.new(0, 200, 0, 30)
AimbotLabel.Position = UDim2.new(0, 10, 0, 100)
AimbotLabel.BackgroundTransparency = 1
AimbotLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotLabel.TextSize = 14
AimbotLabel.Font = Enum.Font.Gotham
AimbotLabel.Text = "⚔️ Aimbot"
AimbotLabel.TextXAlignment = Enum.TextXAlignment.Left
AimbotLabel.Parent = MainFrame

local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Name = "AimbotToggle"
AimbotToggle.Size = UDim2.new(0, 60, 0, 25)
AimbotToggle.Position = UDim2.new(1, -75, 0, 102)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.TextSize = 12
AimbotToggle.Font = Enum.Font.GothamBold
AimbotToggle.Text = "ON"
AimbotToggle.Parent = MainFrame

-- Toggle ESP
local ESPLabel = Instance.new("TextLabel")
ESPLabel.Name = "ESPLabel"
ESPLabel.Size = UDim2.new(0, 200, 0, 30)
ESPLabel.Position = UDim2.new(0, 10, 0, 140)
ESPLabel.BackgroundTransparency = 1
ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPLabel.TextSize = 14
ESPLabel.Font = Enum.Font.Gotham
ESPLabel.Text = "👁️ ESP"
ESPLabel.TextXAlignment = Enum.TextXAlignment.Left
ESPLabel.Parent = MainFrame

local ESPToggle = Instance.new("TextButton")
ESPToggle.Name = "ESPToggle"
ESPToggle.Size = UDim2.new(0, 60, 0, 25)
ESPToggle.Position = UDim2.new(1, -75, 0, 142)
ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.TextSize = 12
ESPToggle.Font = Enum.Font.GothamBold
ESPToggle.Text = "ON"
ESPToggle.Parent = MainFrame

-- Platform Switch
local PlatformLabel = Instance.new("TextLabel")
PlatformLabel.Name = "PlatformLabel"
PlatformLabel.Size = UDim2.new(0, 200, 0, 30)
PlatformLabel.Position = UDim2.new(0, 10, 0, 180)
PlatformLabel.BackgroundTransparency = 1
PlatformLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlatformLabel.TextSize = 14
PlatformLabel.Font = Enum.Font.Gotham
PlatformLabel.Text = "🖥️ Modo"
PlatformLabel.TextXAlignment = Enum.TextXAlignment.Left
PlatformLabel.Parent = MainFrame

local PlatformToggle = Instance.new("TextButton")
PlatformToggle.Name = "PlatformToggle"
PlatformToggle.Size = UDim2.new(0, 60, 0, 25)
PlatformToggle.Position = UDim2.new(1, -75, 0, 182)
PlatformToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
PlatformToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
PlatformToggle.TextSize = 11
PlatformToggle.Font = Enum.Font.GothamBold
PlatformToggle.Text = Config.Platform
PlatformToggle.Parent = MainFrame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 80)
StatusLabel.Position = UDim2.new(0, 10, 0, 310)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Online\nAimbot: ON\nESP: ON"
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextYAlignment = Enum.TextYAlignment.Top
StatusLabel.Parent = MainFrame

-- ==================== FUNÇÕES DE UI ====================
local function updateStatus()
    local aimbotStatus = Config.AimbotEnabled and "ON" or "OFF"
    local espStatus = Config.ESPEnabled and "ON" or "OFF"
    
    StatusLabel.Text = "Status: Online\nAimbot: " .. aimbotStatus .. "\nESP: " .. espStatus
    
    AimbotToggle.BackgroundColor3 = Config.AimbotEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    AimbotToggle.Text = Config.AimbotEnabled and "ON" or "OFF"
    
    ESPToggle.BackgroundColor3 = Config.ESPEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    ESPToggle.Text = Config.ESPEnabled and "ON" or "OFF"
    
    PlatformToggle.Text = Config.Platform
end

-- ==================== EVENTOS DE UI ====================
AimbotToggle.MouseButton1Click:Connect(function()
    Config.AimbotEnabled = not Config.AimbotEnabled
    updateStatus()
end)

ESPToggle.MouseButton1Click:Connect(function()
    Config.ESPEnabled = not Config.ESPEnabled
    updateStatus()
end)

PlatformToggle.MouseButton1Click:Connect(function()
    Config.Platform = Config.Platform == "PC" and "MOBILE" or "PC"
    print("[⚔️ DIVINO FRUTS] Modo alterado para: " .. Config.Platform)
    updateStatus()
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[⚔️ DIVINO FRUTS] Script desativado!")
end)

-- ==================== AIMBOT ====================
local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            local distance = (targetPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude
            if distance < closestDistance and distance <= Config.ESPDistance then
                closestDistance = distance
                closestPlayer = targetPlayer
            end
        end
    end
    
    return closestPlayer
end

local function aimbot()
    if not Config.AimbotEnabled or not player.Character or not player.Character:FindFirstChild("Head") then
        return
    end
    
    local targetPlayer = getClosestPlayer()
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        local targetPosition = targetPlayer.Character.Head.Position
        local direction = (targetPosition - Camera.CFrame.Position).Unit
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
    end
end

-- ==================== ESP ====================
local espPlayers = {}

local function createESP(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Head") then
        return
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. targetPlayer.Name
    billboard.Adornee = targetPlayer.Character.Head
    billboard.MaxDistance = Config.ESPDistance
    billboard.Size = UDim2.new(0, 100, 0, 50)
    
    local textLabel = Instance.new("TextLabel")
    textLabel.BackgroundTransparency = 0
    textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = targetPlayer.Name
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Parent = billboard
    
    billboard.Parent = targetPlayer.Character.Head
    espPlayers[targetPlayer.Name] = billboard
end

local function removeESP(playerName)
    if espPlayers[playerName] then
        espPlayers[playerName]:Destroy()
        espPlayers[playerName] = nil
    end
end

local function updateESP()
    if not Config.ESPEnabled then
        for playerName, _ in pairs(espPlayers) do
            removeESP(playerName)
        end
        return
    end
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
                if not espPlayers[targetPlayer.Name] then
                    createESP(targetPlayer)
                end
            else
                removeESP(targetPlayer.Name)
            end
        end
    end
end

-- ==================== CLEANUP EVENTOS ====================
Players.PlayerRemoving:Connect(function(leftPlayer)
    removeESP(leftPlayer.Name)
end)

-- ==================== LOOP PRINCIPAL ====================
RunService.RenderStepped:Connect(function()
    if Config.Enabled then
        if Config.AimbotEnabled then
            aimbot()
        end
        updateESP()
    end
end)

-- ==================== KEYBOARD SHORTCUTS ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        MainFrame.Visible = not MainFrame.Visible
    end
    
    if input.KeyCode == Enum.KeyCode.F2 then
        Config.Enabled = not Config.Enabled
        print("[⚔️ DIVINO FRUTS] Script " .. (Config.Enabled and "ativado" or "desativado"))
    end
end)

print("[⚔️ DIVINO FRUTS] Script carregado com sucesso!")
print("[⚔️ DIVINO FRUTS] Pressione F1 para abrir/fechar a interface")
print("[⚔️ DIVINO FRUTS] Pressione F2 para ativar/desativar o script")
