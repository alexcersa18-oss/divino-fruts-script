-- MAIN - Divino Fruts Script v2.0
-- Interface Flutuante com Abas + Aimbot Teleguiado + Habilidades Delegadas

print("[⚔️ DIVINO FRUTS] Script iniciando...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ==================== CONFIGURAÇÕES ====================
local Config = {
    AimbotEnabled = true,
    AimbotRange = 100,
    ESPEnabled = true,
    ESPRange = 150,
    SelectedTab = "aimbot",
    GuiVisible = true,
    TargetPlayer = nil,
}

local AbilityKeys = {
    Z = {enabled = true, name = "Habilidade Z"},
    X = {enabled = true, name = "Habilidade X"},
    C = {enabled = true, name = "Habilidade C"},
    V = {enabled = true, name = "Habilidade V"},
    F = {enabled = true, name = "Habilidade F"},
}

-- ==================== CRIAR INTERFACE FLUTUANTE ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DivinoFrutsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Container Principal
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 350, 0, 450)
MainContainer.Position = UDim2.new(0.5, -175, 0.5, -225)
MainContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainContainer.BorderSizePixel = 0
MainContainer.Parent = ScreenGui

-- Adicionar UICorner para cantos arredondados
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainContainer

-- ==================== DRAG & DROP ====================
local dragging = false
local dragStart = nil
local startPos = nil

MainContainer.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = mouse.X
        startPos = MainContainer.Position
    end
end)

MainContainer.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if dragging and dragStart then
        local delta = mouse.X - dragStart
        MainContainer.Position = startPos + UDim2.new(0, delta, 0, 0)
    end
end)

-- ==================== HEADER ====================
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
Header.BorderSizePixel = 0
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Text = "⚔️ DIVINO FRUTS"
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextScaled = false
Title.Parent = Header

local TitlePadding = Instance.new("UIPadding")
TitlePadding.PaddingLeft = UDim.new(0, 15)
TitlePadding.Parent = Title

-- Menu Toggle Button
local MenuBtn = Instance.new("TextButton")
MenuBtn.Name = "MenuBtn"
MenuBtn.Size = UDim2.new(0, 45, 0, 45)
MenuBtn.Position = UDim2.new(1, -50, 0, 2)
MenuBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 80)
MenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuBtn.TextSize = 20
MenuBtn.Font = Enum.Font.GothamBold
MenuBtn.Text = "−"
MenuBtn.BorderSizePixel = 0
MenuBtn.Parent = Header

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 6)
MenuCorner.Parent = MenuBtn

-- ==================== ABAS ====================
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 50)
TabsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainContainer

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.Padding = UDim.new(0, 5)
TabsLayout.Parent = TabsFrame

local AimbotTab = Instance.new("TextButton")
AimbotTab.Name = "AimbotTab"
AimbotTab.Size = UDim2.new(0, 160, 1, 0)
AimbotTab.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
AimbotTab.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotTab.TextSize = 14
AimbotTab.Font = Enum.Font.GothamBold
AimbotTab.Text = "⚔️ AIMBOT"
AimbotTab.BorderSizePixel = 0
AimbotTab.Parent = TabsFrame

local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 5)
AimbotCorner.Parent = AimbotTab

local ESPTab = Instance.new("TextButton")
ESPTab.Name = "ESPTab"
ESPTab.Size = UDim2.new(0, 160, 1, 0)
ESPTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
ESPTab.TextColor3 = Color3.fromRGB(200, 200, 200)
ESPTab.TextSize = 14
ESPTab.Font = Enum.Font.GothamBold
ESPTab.Text = "👁️ ESP"
ESPTab.BorderSizePixel = 0
ESPTab.Parent = TabsFrame

local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 5)
ESPCorner.Parent = ESPTab

-- ==================== CONTEÚDO DAS ABAS ====================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -10, 1, -100)
ContentFrame.Position = UDim2.new(0, 5, 0, 95)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainContainer

-- ========== ABA AIMBOT ==========
local AimbotContent = Instance.new("Frame")
AimbotContent.Name = "AimbotContent"
AimbotContent.Size = UDim2.new(1, 0, 1, 0)
AimbotContent.BackgroundTransparency = 1
AimbotContent.Parent = ContentFrame
AimbotContent.Visible = true

local AimbotScroll = Instance.new("ScrollingFrame")
AimbotScroll.Name = "AimbotScroll"
AimbotScroll.Size = UDim2.new(1, 0, 1, 0)
AimbotScroll.BackgroundTransparency = 1
AimbotScroll.BorderSizePixel = 0
AimbotScroll.ScrollBarThickness = 5
AimbotScroll.Parent = AimbotContent

local AimbotLayout = Instance.new("UIListLayout")
AimbotLayout.Padding = UDim.new(0, 10)
AimbotLayout.Parent = AimbotScroll

-- Toggle Aimbot Principal
local AimbotToggleLabel = Instance.new("TextLabel")
AimbotToggleLabel.Name = "Label"
AimbotToggleLabel.Size = UDim2.new(1, 0, 0, 30)
AimbotToggleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
AimbotToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggleLabel.TextSize = 13
AimbotToggleLabel.Font = Enum.Font.Gotham
AimbotToggleLabel.Text = "⚔️ Aimbot Principal"
AimbotToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
AimbotToggleLabel.BorderSizePixel = 0
AimbotToggleLabel.Parent = AimbotScroll

local AimbotToggleLabelPadding = Instance.new("UIPadding")
AimbotToggleLabelPadding.PaddingLeft = UDim.new(0, 10)
AimbotToggleLabelPadding.Parent = AimbotToggleLabel

local AimbotToggleCorner = Instance.new("UICorner")
AimbotToggleCorner.CornerRadius = UDim.new(0, 5)
AimbotToggleCorner.Parent = AimbotToggleLabel

local AimbotMainToggle = Instance.new("TextButton")
AimbotMainToggle.Name = "Toggle"
AimbotMainToggle.Size = UDim2.new(0, 50, 0, 25)
AimbotMainToggle.Position = UDim2.new(1, -60, 0.5, -12)
AimbotMainToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
AimbotMainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotMainToggle.TextSize = 12
AimbotMainToggle.Font = Enum.Font.GothamBold
AimbotMainToggle.Text = "ON"
AimbotMainToggle.BorderSizePixel = 0
AimbotMainToggle.Parent = AimbotToggleLabel

local AimbotMainCorner = Instance.new("UICorner")
AimbotMainCorner.CornerRadius = UDim.new(0, 4)
AimbotMainCorner.Parent = AimbotMainToggle

-- Aimbot Teleguiado
local AimbotGuideLabel = Instance.new("TextLabel")
AimbotGuideLabel.Name = "Label"
AimbotGuideLabel.Size = UDim2.new(1, 0, 0, 30)
AimbotGuideLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
AimbotGuideLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotGuideLabel.TextSize = 13
AimbotGuideLabel.Font = Enum.Font.Gotham
AimbotGuideLabel.Text = "🎯 Aimbot Teleguiado"
AimbotGuideLabel.TextXAlignment = Enum.TextXAlignment.Left
AimbotGuideLabel.BorderSizePixel = 0
AimbotGuideLabel.Parent = AimbotScroll

local AimbotGuideCorner = Instance.new("UICorner")
AimbotGuideCorner.CornerRadius = UDim.new(0, 5)
AimbotGuideCorner.Parent = AimbotGuideLabel

local AimbotGuidePadding = Instance.new("UIPadding")
AimbotGuidePadding.PaddingLeft = UDim.new(0, 10)
AimbotGuidePadding.Parent = AimbotGuideLabel

local AimbotGuideToggle = Instance.new("TextButton")
AimbotGuideToggle.Name = "Toggle"
AimbotGuideToggle.Size = UDim2.new(0, 50, 0, 25)
AimbotGuideToggle.Position = UDim2.new(1, -60, 0.5, -12)
AimbotGuideToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
AimbotGuideToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotGuideToggle.TextSize = 12
AimbotGuideToggle.Font = Enum.Font.GothamBold
AimbotGuideToggle.Text = "ON"
AimbotGuideToggle.BorderSizePixel = 0
AimbotGuideToggle.Parent = AimbotGuideLabel

local AimbotGuideCorner2 = Instance.new("UICorner")
AimbotGuideCorner2.CornerRadius = UDim.new(0, 4)
AimbotGuideCorner2.Parent = AimbotGuideToggle

-- Habilidades Delegadas
local AbilitiesLabel = Instance.new("TextLabel")
AbilitiesLabel.Name = "Label"
AbilitiesLabel.Size = UDim2.new(1, 0, 0, 30)
AbilitiesLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
AbilitiesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AbilitiesLabel.TextSize = 13
AbilitiesLabel.Font = Enum.Font.Gotham
AbilitiesLabel.Text = "⚡ Habilidades Delegadas"
AbilitiesLabel.TextXAlignment = Enum.TextXAlignment.Left
AbilitiesLabel.BorderSizePixel = 0
AbilitiesLabel.Parent = AimbotScroll

local AbilitiesCorner = Instance.new("UICorner")
AbilitiesCorner.CornerRadius = UDim.new(0, 5)
AbilitiesCorner.Parent = AbilitiesLabel

local AbilitiesPadding = Instance.new("UIPadding")
AbilitiesPadding.PaddingLeft = UDim.new(0, 10)
AbilitiesPadding.Parent = AbilitiesLabel

local AbilitiesToggle = Instance.new("TextButton")
AbilitiesToggle.Name = "Toggle"
AbilitiesToggle.Size = UDim2.new(0, 50, 0, 25)
AbilitiesToggle.Position = UDim2.new(1, -60, 0.5, -12)
AbilitiesToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
AbilitiesToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AbilitiesToggle.TextSize = 12
AbilitiesToggle.Font = Enum.Font.GothamBold
AbilitiesToggle.Text = "ON"
AbilitiesToggle.BorderSizePixel = 0
AbilitiesToggle.Parent = AbilitiesLabel

local AbilitiesCorner2 = Instance.new("UICorner")
AbilitiesCorner2.CornerRadius = UDim.new(0, 4)
AbilitiesCorner2.Parent = AbilitiesToggle

-- Lista de Habilidades
for key, ability in pairs(AbilityKeys) do
    local AbilityBtn = Instance.new("TextButton")
    AbilityBtn.Name = "Ability_" .. key
    AbilityBtn.Size = UDim2.new(1, 0, 0, 25)
    AbilityBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    AbilityBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    AbilityBtn.TextSize = 12
    AbilityBtn.Font = Enum.Font.Gotham
    AbilityBtn.Text = "🎮 " .. key .. " - " .. ability.name
    AbilityBtn.BorderSizePixel = 0
    AbilityBtn.Parent = AimbotScroll
    
    local AbilityCorner = Instance.new("UICorner")
    AbilityCorner.CornerRadius = UDim.new(0, 4)
    AbilityCorner.Parent = AbilityBtn
end

-- Alcance do Aimbot
local RangeLabel = Instance.new("TextLabel")
RangeLabel.Name = "RangeLabel"
RangeLabel.Size = UDim2.new(1, 0, 0, 30)
RangeLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
RangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RangeLabel.TextSize = 12
RangeLabel.Font = Enum.Font.Gotham
RangeLabel.Text = "📏 Alcance: 100 studs"
RangeLabel.TextXAlignment = Enum.TextXAlignment.Left
RangeLabel.BorderSizePixel = 0
RangeLabel.Parent = AimbotScroll

local RangeCorner = Instance.new("UICorner")
RangeCorner.CornerRadius = UDim.new(0, 5)
RangeCorner.Parent = RangeLabel

local RangePadding = Instance.new("UIPadding")
RangePadding.PaddingLeft = UDim.new(0, 10)
RangePadding.Parent = RangeLabel

-- ========== ABA ESP ==========
local ESPContent = Instance.new("Frame")
ESPContent.Name = "ESPContent"
ESPContent.Size = UDim2.new(1, 0, 1, 0)
ESPContent.BackgroundTransparency = 1
ESPContent.Parent = ContentFrame
ESPContent.Visible = false

local ESPScroll = Instance.new("ScrollingFrame")
ESPScroll.Name = "ESPScroll"
ESPScroll.Size = UDim2.new(1, 0, 1, 0)
ESPScroll.BackgroundTransparency = 1
ESPScroll.BorderSizePixel = 0
ESPScroll.ScrollBarThickness = 5
ESPScroll.Parent = ESPContent

local ESPLayout = Instance.new("UIListLayout")
ESPLayout.Padding = UDim.new(0, 10)
ESPLayout.Parent = ESPScroll

-- Toggle ESP Principal
local ESPToggleLabel = Instance.new("TextLabel")
ESPToggleLabel.Name = "Label"
ESPToggleLabel.Size = UDim2.new(1, 0, 0, 30)
ESPToggleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
ESPToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggleLabel.TextSize = 13
ESPToggleLabel.Font = Enum.Font.Gotham
ESPToggleLabel.Text = "👁️ ESP Principal"
ESPToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ESPToggleLabel.BorderSizePixel = 0
ESPToggleLabel.Parent = ESPScroll

local ESPToggleLabelPadding = Instance.new("UIPadding")
ESPToggleLabelPadding.PaddingLeft = UDim.new(0, 10)
ESPToggleLabelPadding.Parent = ESPToggleLabel

local ESPToggleLabelCorner = Instance.new("UICorner")
ESPToggleLabelCorner.CornerRadius = UDim.new(0, 5)
ESPToggleLabelCorner.Parent = ESPToggleLabel

local ESPMainToggle = Instance.new("TextButton")
ESPMainToggle.Name = "Toggle"
ESPMainToggle.Size = UDim2.new(0, 50, 0, 25)
ESPMainToggle.Position = UDim2.new(1, -60, 0.5, -12)
ESPMainToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ESPMainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPMainToggle.TextSize = 12
ESPMainToggle.Font = Enum.Font.GothamBold
ESPMainToggle.Text = "ON"
ESPMainToggle.BorderSizePixel = 0
ESPMainToggle.Parent = ESPToggleLabel

local ESPMainCorner = Instance.new("UICorner")
ESPMainCorner.CornerRadius = UDim.new(0, 4)
ESPMainCorner.Parent = ESPMainToggle

-- Alcance do ESP
local ESPRangeLabel = Instance.new("TextLabel")
ESPRangeLabel.Name = "RangeLabel"
ESPRangeLabel.Size = UDim2.new(1, 0, 0, 30)
ESPRangeLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
ESPRangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPRangeLabel.TextSize = 12
ESPRangeLabel.Font = Enum.Font.Gotham
ESPRangeLabel.Text = "📏 Alcance: 150 studs"
ESPRangeLabel.TextXAlignment = Enum.TextXAlignment.Left
ESPRangeLabel.BorderSizePixel = 0
ESPRangeLabel.Parent = ESPScroll

local ESPRangeCorner = Instance.new("UICorner")
ESPRangeCorner.CornerRadius = UDim.new(0, 5)
ESPRangeCorner.Parent = ESPRangeLabel

local ESPRangePadding = Instance.new("UIPadding")
ESPRangePadding.PaddingLeft = UDim.new(0, 10)
ESPRangePadding.Parent = ESPRangeLabel

-- Inimigos Detectados
local EnemiesLabel = Instance.new("TextLabel")
EnemiesLabel.Name = "EnemiesLabel"
EnemiesLabel.Size = UDim2.new(1, 0, 0, 30)
EnemiesLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
EnemiesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EnemiesLabel.TextSize = 12
EnemiesLabel.Font = Enum.Font.Gotham
EnemiesLabel.Text = "👥 Inimigos: 0"
EnemiesLabel.TextXAlignment = Enum.TextXAlignment.Left
EnemiesLabel.BorderSizePixel = 0
EnemiesLabel.Parent = ESPScroll

local EnemiesCorner = Instance.new("UICorner")
EnemiesCorner.CornerRadius = UDim.new(0, 5)
EnemiesCorner.Parent = EnemiesLabel

local EnemiesPadding = Instance.new("UIPadding")
EnemiesPadding.PaddingLeft = UDim.new(0, 10)
EnemiesPadding.Parent = EnemiesLabel

-- ==================== GERENCIAMENTO DE ABAS ====================
local function selectTab(tabName)
    Config.SelectedTab = tabName
    
    if tabName == "aimbot" then
        AimbotContent.Visible = true
        ESPContent.Visible = false
        AimbotTab.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
        AimbotTab.TextColor3 = Color3.fromRGB(255, 255, 255)
        ESPTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        ESPTab.TextColor3 = Color3.fromRGB(200, 200, 200)
    else
        AimbotContent.Visible = false
        ESPContent.Visible = true
        AimbotTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        AimbotTab.TextColor3 = Color3.fromRGB(200, 200, 200)
        ESPTab.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
        ESPTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

AimbotTab.MouseButton1Click:Connect(function()
    selectTab("aimbot")
end)

ESPTab.MouseButton1Click:Connect(function()
    selectTab("esp")
end)

-- Menu Toggle
local guiVisible = true
MenuBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    AimbotContent.Parent.Parent.Visible = guiVisible
    if guiVisible then
        MenuBtn.Text = "−"
    else
        MenuBtn.Text = "+"
    end
end)

-- ==================== FUNÇÕES DO AIMBOT ====================
local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            local distance = (targetPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude
            if distance < closestDistance and distance <= Config.AimbotRange then
                closestDistance = distance
                closestPlayer = targetPlayer
            end
        end
    end
    
    return closestPlayer
end

local aimbotEnabled = true
local aimbotGuideEnabled = true
local abilitiesEnabled = true

AimbotMainToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotMainToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    AimbotMainToggle.Text = aimbotEnabled and "ON" or "OFF"
end)

AimbotGuideToggle.MouseButton1Click:Connect(function()
    aimbotGuideEnabled = not aimbotGuideEnabled
    AimbotGuideToggle.BackgroundColor3 = aimbotGuideEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    AimbotGuideToggle.Text = aimbotGuideEnabled and "ON" or "OFF"
end)

AbilitiesToggle.MouseButton1Click:Connect(function()
    abilitiesEnabled = not abilitiesEnabled
    AbilitiesToggle.BackgroundColor3 = abilitiesEnabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    AbilitiesToggle.Text = abilitiesEnabled and "ON" or "OFF"
end)

-- ==================== AIMBOT TELEGUIADO ====================
local function useAbilityOnTarget(abilityKey)
    if not abilitiesEnabled or not aimbotGuideEnabled then return end
    
    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        Config.TargetPlayer = target
        print("[⚔️ DIVINO FRUTS] Habilidade " .. abilityKey .. " ativada em: " .. target.Name)
        -- Aqui você adiciona a lógica real da habilidade
        -- Exemplo: aim na cabeça do alvo
        if player.Character and player.Character:FindFirstChild("Head") then
            local direction = (target.Character.Head.Position - player.Character.Head.Position).Unit
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
        end
    end
end

-- ==================== HOTKEYS DAS HABILIDADES ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    local keyName = input.KeyCode.Name
    
    if keyName == "Z" or keyName == "X" or keyName == "C" or keyName == "V" or keyName == "F" then
        useAbilityOnTarget(keyName)
    end
    
    -- Toggle da UI com M
    if keyName == "M" then
        guiVisible = not guiVisible
        AimbotContent.Parent.Parent.Visible = guiVisible
        MenuBtn.Text = guiVisible and "−" or "+"
    end
end)

-- ==================== LOOP DO AIMBOT ====================
RunService.RenderStepped:Connect(function()
    if aimbotEnabled and player.Character and player.Character:FindFirstChild("Head") then
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Config.TargetPlayer = target
            -- Aimbot suave
            local targetPos = target.Character.Head.Position
            local direction = (targetPos - Camera.CFrame.Position).Unit
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction), 0.1)
        end
    end
end)

print("[⚔️ DIVINO FRUTS] Script carregado com sucesso!")
print("[⚔️ DIVINO FRUTS] Pressione M para abrir/fechar a interface")
print("[⚔️ DIVINO FRUTS] Pressione Z, X, C, V ou F para usar habilidades")
